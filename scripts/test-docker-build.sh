#!/bin/bash
set -e

# Extract Node version from .nvmrc
NODE_VERSION=$(cat .nvmrc)

echo "🔨 Building TypeScript..."
npm run build

echo ""
echo "🐳 Building Docker image with Node ${NODE_VERSION}..."
docker build --build-arg NODE_VERSION=${NODE_VERSION} -t homebridge-mcp-server:local .

echo ""
echo "✅ Build complete!"
echo "   Image: homebridge-mcp-server:local"
echo "   Node version: ${NODE_VERSION}"
echo ""
echo "To test the image locally:"
echo "  docker run --rm homebridge-mcp-server:local"
echo ""
echo "To inspect the image:"
echo "  docker run --rm -it homebridge-mcp-server:local sh"
echo "  docker images homebridge-mcp-server:local"
