#!/bin/bash

# Graphiti Azure Deployment Setup Script
# This script configures the environment and deploys Graphiti to Azure Container Apps

set -e

echo "🚀 Setting up Graphiti deployment to Azure..."

# Configuration
export AZURE_ENV_NAME="graphiti-prod"
export AZURE_LOCATION="westus2"
export AZURE_SUBSCRIPTION_ID="99a03521-8275-435d-aed7-df82bf1b2fec"
export AZURE_TENANT_ID="6dd30942-a761-44b3-bc22-4fd7a954c6f5"
export OPENAI_API_KEY="your-openai-api-key-here"
export NEO4J_PASSWORD="GRaPh@Cr0wn"
export NEO4J_USER="neo4j"
export NEO4J_PORT="7687"

echo "📋 Configuration:"
echo "  Environment: $AZURE_ENV_NAME"
echo "  Location: $AZURE_LOCATION"
echo "  Subscription: $AZURE_SUBSCRIPTION_ID"
echo "  Tenant: $AZURE_TENANT_ID"
echo "  Neo4j Password: $NEO4J_PASSWORD"
echo ""

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI is not installed. Please install it first:"
    echo "   https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if Azure Developer CLI is installed
if ! command -v azd &> /dev/null; then
    echo "❌ Azure Developer CLI is not installed. Please install it first:"
    echo "   https://docs.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd"
    exit 1
fi

echo "✅ Azure CLI and azd are installed"

# Login to Azure
echo "🔐 Logging into Azure..."
if ! az account show &> /dev/null; then
    echo "Please login to Azure CLI:"
    az login --tenant $AZURE_TENANT_ID
fi

# Set the subscription
echo "📝 Setting Azure subscription..."
az account set --subscription $AZURE_SUBSCRIPTION_ID

# Initialize azd environment
echo "🌱 Initializing azd environment..."
azd env new $AZURE_ENV_NAME --location $AZURE_LOCATION --subscription $AZURE_SUBSCRIPTION_ID

# Set environment variables
echo "⚙️ Setting environment variables..."
azd env set AZURE_ENV_NAME $AZURE_ENV_NAME
azd env set AZURE_LOCATION $AZURE_LOCATION
azd env set AZURE_SUBSCRIPTION_ID $AZURE_SUBSCRIPTION_ID
azd env set AZURE_TENANT_ID $AZURE_TENANT_ID
azd env set OPENAI_API_KEY $OPENAI_API_KEY
azd env set NEO4J_PASSWORD $NEO4J_PASSWORD
azd env set NEO4J_USER $NEO4J_USER
azd env set NEO4J_PORT $NEO4J_PORT

# Deploy to Azure
echo "🚀 Deploying to Azure..."
azd provision

# Build and deploy the applications
echo "🔨 Building and deploying applications..."
azd deploy

echo ""
echo "🎉 Deployment completed successfully!"
echo ""
echo "📊 Access URLs:"
echo "  Main API: $(azd env get-value GRAPHITI_API_URL)"
echo "  MCP Server: $(azd env get-value GRAPHITI_MCP_URL)"
echo "  Neo4j Browser: $(azd env get-value NEO4J_BROWSER_URL)"
echo "  Neo4j Bolt: $(azd env get-value NEO4J_BOLT_URL)"
echo ""
echo "🔐 Credentials:"
echo "  Neo4j Username: neo4j"
echo "  Neo4j Password: $NEO4J_PASSWORD"
echo ""
echo "✅ All services are now running and accessible from the internet!"
echo ""
echo "🎯 For Cursor MCP integration, use the MCP Server URL: $(azd env get-value GRAPHITI_MCP_URL)" 