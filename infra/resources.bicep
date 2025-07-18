targetScope = 'resourceGroup'

@description('Name of the environment that will be used to name resources')
param environmentName string

@description('Primary location for all resources')
param location string

@description('OpenAI API Key')
@secure()
param openAiApiKey string

@description('Neo4j password')
@secure()
param neo4jPassword string

@description('Azure subscription ID')
param subscriptionId string

@description('Azure tenant ID')
param tenantId string

@description('Resource token for unique naming')
param resourceToken string

@description('Container App Environment name')
param containerAppEnvName string

@description('Container Registry name')
param containerRegistryName string

@description('Log Analytics name')
param logAnalyticsName string

@description('Key Vault name')
param keyVaultName string

@description('Neo4j Container name')
param neo4jContainerName string



@description('Graphiti MCP name')
param graphitiMcpName string

// Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

// Key Vault for storing secrets
resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enabledForTemplateDeployment: true
    enableRbacAuthorization: true
  }
}

// Container Registry
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

// Container App Environment
resource containerAppEnvironment 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: containerAppEnvName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: logAnalytics.listKeys().primarySharedKey
      }
    }
  }
}

// Neo4j Container Instance
resource neo4jContainer 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: neo4jContainerName
  location: location
  properties: {
    containers: [
      {
        name: 'neo4j'
        properties: {
          image: 'neo4j:5.26.2'
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
          ports: [
            {
              port: 7474
              protocol: 'TCP'
            }
            {
              port: 7687
              protocol: 'TCP'
            }
          ]
          environmentVariables: [
            {
              name: 'NEO4J_AUTH'
              value: 'neo4j/${neo4jPassword}'
            }
            {
              name: 'NEO4J_server_memory_heap_initial__size'
              value: '512m'
            }
            {
              name: 'NEO4J_server_memory_heap_max__size'
              value: '1G'
            }
            {
              name: 'NEO4J_server_memory_pagecache_size'
              value: '512m'
            }
          ]
          volumeMounts: [
            {
              name: 'neo4j-data'
              mountPath: '/data'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: 'Always'
    ipAddress: {
      type: 'Public'
      ports: [
        {
          port: 7474
          protocol: 'TCP'
        }
        {
          port: 7687
          protocol: 'TCP'
        }
      ]
    }
    volumes: [
      {
        name: 'neo4j-data'
        azureFile: {
          storageAccountName: storageAccount.name
          storageAccountKey: storageAccount.listKeys().keys[0].value
          shareName: 'neo4j-data'
        }
      }
    ]
  }
}

// Storage Account for Neo4j data persistence
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: take('${resourceToken}storage', 24)
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// File Share for Neo4j data
resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-01-01' = {
  name: '${storageAccount.name}/default/neo4j-data'
  properties: {
    shareQuota: 10
  }
}



// Graphiti MCP Container App
resource graphitiMcpApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: graphitiMcpName
  location: location
  properties: {
    managedEnvironmentId: containerAppEnvironment.id
    configuration: {
      secrets: [
        {
          name: 'openai-api-key'
          value: openAiApiKey
        }
        {
          name: 'neo4j-password'
          value: neo4jPassword
        }
        {
          name: 'registry-password'
          value: containerRegistry.listCredentials().passwords[0].value
        }
      ]
      ingress: {
        external: true
        targetPort: 8000
        transport: 'http'
        allowInsecure: false
      }
      registries: [
        {
          server: containerRegistry.properties.loginServer
          username: containerRegistry.listCredentials().username
          passwordSecretRef: 'registry-password'
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'graphiti-mcp'
          image: '${containerRegistry.properties.loginServer}/graphiti-mcp:latest'
          resources: {
            cpu: json('0.5')
            memory: '1Gi'
          }
          env: [
            {
              name: 'OPENAI_API_KEY'
              secretRef: 'openai-api-key'
            }
            {
              name: 'NEO4J_URI'
              value: 'bolt://${neo4jContainer.properties.ipAddress.ip}:7687'
            }
            {
              name: 'NEO4J_USER'
              value: 'neo4j'
            }
            {
              name: 'NEO4J_PASSWORD'
              secretRef: 'neo4j-password'
            }
            {
              name: 'MODEL_NAME'
              value: 'gpt-4o-mini'
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 2
      }
    }
  }
}

// Outputs
output GRAPHITI_MCP_URL string = 'https://${graphitiMcpApp.properties.configuration.ingress.fqdn}/sse'
output NEO4J_BROWSER_URL string = 'http://${neo4jContainer.properties.ipAddress.ip}:7474'
output NEO4J_BOLT_URL string = 'bolt://${neo4jContainer.properties.ipAddress.ip}:7687'
output AZURE_CONTAINER_REGISTRY_ENDPOINT string = containerRegistry.properties.loginServer
output AZURE_CONTAINER_REGISTRY_NAME string = containerRegistry.name
output AZURE_KEY_VAULT_NAME string = keyVault.name 