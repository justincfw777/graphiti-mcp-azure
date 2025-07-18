# Graphiti Azure Deployment Instructions

## 🚀 Quick Start

### 1. Prerequisites Check

Ensure you have the required tools installed:

```bash
# Check Azure CLI
az --version

# Check Azure Developer CLI
azd version

# Check Docker
docker --version
```

### 2. Azure Login

```bash
# Login to Azure with your tenant
az login --tenant 6dd30942-a761-44b3-bc22-4fd7a954c6f5

# Set the subscription
az account set --subscription 99a03521-8275-435d-aed7-df82bf1b2fec
```

### 3. Automated Deployment

Run the setup script:

```bash
./setup.sh
```

This script will:
- Initialize the azd environment
- Set all required environment variables
- Deploy the infrastructure to Azure
- Build and deploy the container applications
- Display the access URLs

## 📊 Expected Output URLs

After successful deployment, you should see URLs similar to:

```
🎉 Deployment completed successfully!

📊 Access URLs:
  Main API: https://graphiti-prod-abc123-api.westus2.azurecontainerapps.io
  MCP Server: https://graphiti-prod-abc123-mcp.westus2.azurecontainerapps.io/sse
  Neo4j Browser: http://20.123.45.67:7474
  Neo4j Bolt: bolt://20.123.45.67:7687

🔐 Credentials:
  Neo4j Username: neo4j
  Neo4j Password: GRaPh@Cr0wn

✅ All services are now running and accessible from the internet!

🎯 For Cursor MCP integration, use the MCP Server URL: https://graphiti-prod-abc123-mcp.westus2.azurecontainerapps.io/sse
```

## 🎯 Cursor MCP Integration

### 1. Update Cursor Configuration

Replace the placeholder in `cursor-mcp-config.json` with your actual MCP server URL:

```json
{
  "mcpServers": {
    "graphiti-memory": {
      "url": "https://graphiti-prod-abc123-mcp.westus2.azurecontainerapps.io/sse",
      "description": "Graphiti knowledge graph memory system for AI agents"
    }
  }
}
```

### 2. Add to Cursor Settings

1. Open Cursor
2. Go to Settings (Cmd/Ctrl + ,)
3. Search for "MCP"
4. Add the configuration from `cursor-mcp-config.json`

### 3. Add Graphiti Rules

Copy the rules from the original Graphiti repository's `cursor_rules.md` to your Cursor User Rules.

## 🔍 Verification Steps

### 1. Check Service Health

```bash
# Check Container Apps status
az containerapp list --resource-group graphiti-prod-{token}-rg --output table

# Check Neo4j container
az container list --resource-group graphiti-prod-{token}-rg --output table
```

### 2. Test API Endpoints

```bash
# Test Graphiti API health
curl https://graphiti-prod-{token}-api.westus2.azurecontainerapps.io/healthcheck

# Test MCP Server health
curl https://graphiti-prod-{token}-mcp.westus2.azurecontainerapps.io/health
```

### 3. Access Neo4j Browser

1. Open the Neo4j Browser URL in your browser
2. Login with:
   - Username: `neo4j`
   - Password: `GRaPh@Cr0wn`
3. You may need to change the password on first login

## 🛠️ Troubleshooting

### Common Issues

1. **Container Build Fails**
   ```bash
   # Check build logs
   az containerapp logs show --name graphiti-prod-{token}-api --resource-group graphiti-prod-{token}-rg
   ```

2. **Neo4j Connection Issues**
   ```bash
   # Check Neo4j container logs
   az container logs --name graphiti-prod-{token}-neo4j --resource-group graphiti-prod-{token}-rg
   ```

3. **OpenAI API Errors**
   - Verify the API key is correct
   - Check OpenAI account has sufficient credits
   - Ensure the API key has access to the required models

### Manual Deployment Steps

If the automated script fails, you can deploy manually:

```bash
# 1. Initialize environment
azd env new graphiti-prod --location westus2 --subscription 99a03521-8275-435d-aed7-df82bf1b2fec

# 2. Set environment variables
azd env set AZURE_ENV_NAME graphiti-prod
azd env set AZURE_LOCATION westus2
azd env set AZURE_SUBSCRIPTION_ID 99a03521-8275-435d-aed7-df82bf1b2fec
azd env set AZURE_TENANT_ID 6dd30942-a761-44b3-bc22-4fd7a954c6f5
azd env set OPENAI_API_KEY "your-openai-api-key-here"
azd env set NEO4J_PASSWORD "GRaPh@Cr0wn"
azd env set NEO4J_USER neo4j
azd env set NEO4J_PORT 7687

# 3. Deploy infrastructure
azd provision

# 4. Deploy applications
azd deploy
```

## 🧹 Cleanup

To remove all Azure resources and stop billing:

```bash
azd down
```

## 📞 Support

- **Azure Issues**: Check Azure documentation or contact Azure support
- **Graphiti Issues**: Check the [Graphiti repository](https://github.com/getzep/graphiti)
- **Deployment Issues**: Review the logs and check the troubleshooting section above 