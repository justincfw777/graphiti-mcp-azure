targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that will be used to name resources')
param environmentName string

@minLength(1)
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

// Generate a unique suffix for resource names
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))
var prefix = '${environmentName}-${resourceToken}'

// Ensure names are within Azure limits and follow naming conventions
var containerAppEnvName = take('${prefix}-env', 32)
var containerRegistryName = take(replace('${prefix}acr', '-', ''), 50)
var logAnalyticsName = take('${prefix}-logs', 63)
var keyVaultName = take('${prefix}-kv', 24)
var neo4jContainerName = take('${prefix}-neo4j', 63)
var graphitiMcpName = take('${prefix}-mcp', 32)

// Resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${prefix}-rg'
  location: location
}

// Deploy the main resources
module resources './resources.bicep' = {
  name: 'resources'
  scope: rg
  params: {
    environmentName: environmentName
    location: location
    openAiApiKey: openAiApiKey
    neo4jPassword: neo4jPassword
    subscriptionId: subscriptionId
    tenantId: tenantId
    resourceToken: resourceToken
    containerAppEnvName: containerAppEnvName
    containerRegistryName: containerRegistryName
    logAnalyticsName: logAnalyticsName
    keyVaultName: keyVaultName
    neo4jContainerName: neo4jContainerName
    graphitiMcpName: graphitiMcpName
  }
}

// Output the important URLs and connection strings
output GRAPHITI_MCP_URL string = resources.outputs.GRAPHITI_MCP_URL
output NEO4J_BROWSER_URL string = resources.outputs.NEO4J_BROWSER_URL
output NEO4J_BOLT_URL string = resources.outputs.NEO4J_BOLT_URL
output NEO4J_PASSWORD string = neo4jPassword
output AZURE_CONTAINER_REGISTRY_ENDPOINT string = resources.outputs.AZURE_CONTAINER_REGISTRY_ENDPOINT
output AZURE_CONTAINER_REGISTRY_NAME string = resources.outputs.AZURE_CONTAINER_REGISTRY_NAME
output AZURE_KEY_VAULT_NAME string = resources.outputs.AZURE_KEY_VAULT_NAME 