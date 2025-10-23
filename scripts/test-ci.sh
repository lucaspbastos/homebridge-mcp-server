#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧪 Simulating CI workflow (quality + build checks)${NC}"
echo ""

# Quality checks (parallel in real CI, sequential here)
echo -e "${BLUE}📝 Running lint...${NC}"
if npm run lint; then
    echo -e "${GREEN}✅ Lint passed${NC}"
else
    echo -e "${RED}❌ Lint failed${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}🧪 Running tests...${NC}"
if npm test; then
    echo -e "${GREEN}✅ Tests passed${NC}"
else
    echo -e "${RED}❌ Tests failed${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}🔨 Building TypeScript...${NC}"
if npm run build; then
    echo -e "${GREEN}✅ Build passed${NC}"
else
    echo -e "${RED}❌ Build failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ All CI checks passed!${NC}"
echo ""
echo "This branch is ready for a PR to main 🚀"
