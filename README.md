# Graphiti MCP Azure Deployment

A complete Azure deployment system for Graphiti knowledge graph memory system, designed for integration with Cursor IDE and AI agents.

## 🏗️ Overview

This project provides a streamlined Azure deployment of Graphiti MCP (Model Context Protocol) server using Azure Developer CLI (azd) with Bicep infrastructure as code. The deployment creates a knowledge graph memory system that enables AI agents in Cursor IDE to maintain context and remember information across sessions.

## ✨ Features

### 🚀 One-Click Deployment
- **Automated Setup**: Complete deployment with a single script execution
- **Azure Developer CLI**: Modern deployment tooling with Bicep templates
- **Infrastructure as Code**: Reproducible deployments with version control
- **Optimized Architecture**: Streamlined services for cost efficiency

### 🧠 Knowledge Graph Memory
- **Persistent Memory**: AI agents can store and retrieve information across sessions
- **Contextual Understanding**: Enhanced AI performance through memory retention
- **Graph Database**: Neo4j for efficient relationship storage and querying
- **MCP Protocol**: Standard protocol for AI agent memory integration

### 🔧 Cursor IDE Integration
- **Seamless Integration**: Direct MCP server connection to Cursor IDE
- **Enhanced AI Capabilities**: AI agents with persistent memory and context
- **Real-time Synchronization**: Instant memory updates across sessions
- **Simple Configuration**: Easy setup with provided configuration files

### ☁️ Azure Cloud Infrastructure
- **Container Apps**: Scalable, serverless container hosting
- **Neo4j Database**: Dedicated graph database container instance
- **Azure OpenAI**: Integrated AI processing capabilities
- **Security**: Azure Key Vault for secure credential management

## 🛠️ Technology Stack

- **Infrastructure**: Azure Developer CLI (azd), Bicep templates
- **Database**: Neo4j 5.26.2 (Container Instance)
- **MCP Server**: Official Docker image (`zepai/knowledge-graph-mcp:latest`)
- **AI**: Azure OpenAI (GPT-4.1-mini)
- **Hosting**: Azure Container Apps, Azure Container Instances
- **Security**: Azure Key Vault, managed identities

## 📁 Project Structure

```
Graphiti/
├── azure.yaml                    # Azure Developer CLI configuration
├── setup.sh                      # One-click deployment script
├── cursor-mcp-config.json        # Cursor IDE MCP configuration
├── infra/
│   ├── main.bicep                # Main infrastructure template
│   ├── main.parameters.json      # Template parameters
│   └── resources.bicep           # Resource definitions
├── DEPLOYMENT_INSTRUCTIONS.md    # Detailed deployment guide
├── DEPLOYMENT_SUMMARY.md         # Current deployment status
└── README.md                     # This file
```

## 🚀 Quick Start

### Prerequisites

Ensure you have the required tools installed:

```bash
# Check Azure CLI
az --version

# Check Azure Developer CLI
azd version

# Check Docker (optional, for local testing)
docker --version
```

### 1. Clone and Setup

```bash
git clone https://github.com/justincfw777/graphiti-mcp-azure.git
cd graphiti-mcp-azure
```

### 2. Configure OpenAI API Key

Edit `setup.sh` and replace the placeholder with your actual OpenAI API key:

```bash
export OPENAI_API_KEY="your-actual-openai-api-key-here"
```

### 3. Deploy to Azure

```bash
# Run the automated deployment script
./setup.sh
```

The script will:
- Login to Azure and set the subscription
- Initialize the azd environment
- Deploy the infrastructure using Bicep templates
- Build and deploy the container applications
- Display access URLs and credentials

### 4. Configure Cursor IDE

After deployment, update `cursor-mcp-config.json` with your MCP server URL and add it to Cursor settings.

## 📊 Deployed Services

After successful deployment, you'll have:

### 🔗 Access URLs
- **MCP Server**: `https://graphiti-prod-{token}-mcp.westus2.azurecontainerapps.io/sse`
- **Neo4j Browser**: `http://{public-ip}:7474`
- **Neo4j Bolt**: `bolt://{public-ip}:7687`

### 🔐 Credentials
- **Neo4j Username**: `neo4j`
- **Neo4j Password**: `GRaPh@Cr0wn`

### 🏗️ Architecture Components
- **Neo4j Database** (Container Instance) - Graph database for knowledge storage
- **MCP Server** (Container App) - Cursor IDE integration endpoint
- **Container App Environment** - Runtime environment for containerized services
- **Supporting Services** - Registry, Key Vault, Storage, Logs

## 🎯 Cursor Integration

### 1. MCP Configuration

Use the configuration from `cursor-mcp-config.json`:

```json
{
  "mcpServers": {
    "graphiti-memory": {
      "url": "https://your-mcp-server-url/sse",
      "description": "Graphiti knowledge graph memory system for AI agents"
    }
  }
}
```

### 2. Cursor Setup

1. Open Cursor IDE
2. Go to Settings (Cmd/Ctrl + ,)
3. Search for "MCP"
4. Add the configuration from step 1
5. Restart Cursor

### 3. Usage

Once configured, AI agents in Cursor will automatically:
- Store important information in the knowledge graph
- Retrieve relevant context from previous sessions
- Maintain conversation history and learned preferences
- Build understanding over time

## 🔧 Configuration

### Environment Variables

The deployment uses these key environment variables:

```bash
AZURE_ENV_NAME="graphiti-prod"
AZURE_LOCATION="westus2"
AZURE_SUBSCRIPTION_ID="your-subscription-id"
AZURE_TENANT_ID="your-tenant-id"
OPENAI_API_KEY="your-openai-api-key"
NEO4J_PASSWORD="GRaPh@Cr0wn"
NEO4J_USER="neo4j"
MODEL_NAME="gpt-4.1-mini"
```

### Customization

You can customize the deployment by:
- Modifying `infra/main.bicep` for infrastructure changes
- Updating `azure.yaml` for service configuration
- Adjusting environment variables in `setup.sh`

## 🔍 Monitoring and Troubleshooting

### Health Checks

```bash
# Check Container Apps status
az containerapp list --resource-group graphiti-prod-{token}-rg --output table

# Check Neo4j container
az container list --resource-group graphiti-prod-{token}-rg --output table

# View MCP server logs
az containerapp logs show --name graphiti-prod-{token}-mcp --resource-group graphiti-prod-{token}-rg
```

### Common Issues

1. **OpenAI API Key**: Ensure your API key is valid and has sufficient credits
2. **Neo4j Connection**: Check container logs if database connection fails
3. **MCP Integration**: Verify the MCP server URL is correct in Cursor settings

## 🧹 Cleanup

To remove all Azure resources:

```bash
azd down
```

This will delete all resources and stop billing.

## 📚 Documentation

For detailed information:
- [`DEPLOYMENT_INSTRUCTIONS.md`](DEPLOYMENT_INSTRUCTIONS.md) - Step-by-step deployment guide
- [`DEPLOYMENT_SUMMARY.md`](DEPLOYMENT_SUMMARY.md) - Current deployment status
- [Graphiti Documentation](https://github.com/getzep/graphiti) - Official Graphiti project

## 🔒 Security

- **Secrets Management**: OpenAI API key and Neo4j password stored in Azure Key Vault
- **Network Security**: Container apps with managed ingress and egress
- **Access Control**: Azure RBAC for resource management
- **Encryption**: Data encrypted at rest and in transit

## 🤝 Contributing

This project is optimized for the specific Azure deployment scenario. To contribute:

1. Fork the repository
2. Create a feature branch
3. Test your changes with `azd provision`
4. Submit a pull request

## 📄 License

This project is for CrownBio internal use. The underlying Graphiti project is licensed under the Apache License 2.0.

## 📞 Support

For support:
- **Azure Issues**: Check Azure documentation or contact Azure support
- **Graphiti Issues**: See the [Graphiti repository](https://github.com/getzep/graphiti)
- **Deployment Issues**: Review logs and check the troubleshooting section

---

**Note**: This deployment has been optimized to include only essential services for cost efficiency. The API service has been removed as it was not needed for MCP functionality. 