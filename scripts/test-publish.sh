#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}⚠️  This script simulates the release workflow locally${NC}"
echo -e "${YELLOW}   It does NOT actually publish to npm or Docker registries${NC}"
echo ""

# Extract Node version from .nvmrc
NODE_VERSION=$(cat .nvmrc)

# Get current version from package.json
CURRENT_VERSION=$(node -p "require('./package.json').version")
echo -e "${BLUE}📦 Current version: ${CURRENT_VERSION}${NC}"

# Prompt for version bump
echo ""
echo "Select version bump:"
echo "  1) patch (${CURRENT_VERSION} → x.x.x+1)"
echo "  2) minor (${CURRENT_VERSION} → x.x+1.0)"
echo "  3) major (${CURRENT_VERSION} → x+1.0.0)"
read -p "Enter choice [1-3]: " choice

case $choice in
  1) BUMP_TYPE="patch" ;;
  2) BUMP_TYPE="minor" ;;
  3) BUMP_TYPE="major" ;;
  *) echo "Invalid choice"; exit 1 ;;
esac

echo ""
echo -e "${BLUE}🔨 Running quality checks...${NC}"
npm run lint
npm test

echo ""
echo -e "${BLUE}📝 Bumping version (${BUMP_TYPE})...${NC}"
NEW_VERSION=$(npm version ${BUMP_TYPE} --no-git-tag-version)
echo -e "${GREEN}   New version: ${NEW_VERSION}${NC}"

echo ""
echo -e "${BLUE}🔨 Building TypeScript...${NC}"
npm run build

echo ""
echo -e "${BLUE}🐳 Building Docker image with Node ${NODE_VERSION}...${NC}"
docker build --build-arg NODE_VERSION=${NODE_VERSION} \
  -t homebridge-mcp-server:${NEW_VERSION} \
  -t homebridge-mcp-server:latest \
  .

echo ""
echo -e "${GREEN}✅ Local release simulation complete!${NC}"
echo ""
echo "📦 Package version updated to: ${NEW_VERSION}"
echo "🐳 Docker images created:"
echo "  - homebridge-mcp-server:${NEW_VERSION}"
echo "  - homebridge-mcp-server:latest"
echo ""
echo -e "${YELLOW}⚠️  Remember to revert package.json if this was just a test:${NC}"
echo "   git checkout package.json package-lock.json"
echo ""
echo "To test the release image:"
echo "  docker run --rm homebridge-mcp-server:${NEW_VERSION}"
