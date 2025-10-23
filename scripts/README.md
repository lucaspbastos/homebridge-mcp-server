# Local Testing Scripts

These scripts help you test the CI/CD workflows locally before pushing to GitHub.

## Scripts Overview

### `test-ci.sh` - CI Workflow Simulation
Simulates the GitHub Actions CI workflow that runs on feature branches and PRs.

**What it does:**
- ✅ Runs lint checks
- ✅ Runs tests
- ✅ Builds TypeScript

**Usage:**
```bash
./scripts/test-ci.sh
```

**When to use:**
- Before pushing to feature branch
- Before creating a PR
- Quick validation during development

---

### `test-docker-build.sh` - Local Docker Build
Builds a Docker image locally for testing.

**What it does:**
- ✅ Builds TypeScript
- ✅ Builds Docker image with `:local` tag
- ℹ️  Does NOT push to any registry

**Usage:**
```bash
./scripts/test-docker-build.sh
```

**After building:**
```bash
# Test the image
docker run --rm homebridge-mcp-server:local

# Inspect the image
docker run --rm -it homebridge-mcp-server:local sh

# Check image size
docker images homebridge-mcp-server:local
```

**When to use:**
- Testing Dockerfile changes
- Verifying image size
- Testing runtime behavior

---

### `test-publish.sh` - Release Workflow Simulation
Simulates the full release workflow including version bumping and Docker builds.

**What it does:**
- ✅ Runs quality checks (lint + test)
- ✅ Prompts for version bump (patch/minor/major)
- ✅ Updates package.json version
- ✅ Builds TypeScript
- ✅ Builds Docker images with version tags
- ⚠️  Does NOT publish to npm or Docker registries
- ⚠️  Does NOT create git tags or commits

**Usage:**
```bash
./scripts/test-publish.sh
```

**Interactive prompts:**
1. Select version bump type (1=patch, 2=minor, 3=major)
2. Script runs all checks and builds

**Important:**
This script modifies `package.json` and `package-lock.json`. If this was just a test, revert:
```bash
git checkout package.json package-lock.json
```

**When to use:**
- Before triggering actual release workflow
- Testing version bump logic
- Validating full release pipeline locally

---

## Workflow Comparison

| Script | Simulates | Publishes? | Modifies Files? |
|--------|-----------|------------|-----------------|
| `test-ci.sh` | CI workflow | ❌ No | ❌ No |
| `test-docker-build.sh` | Docker build | ❌ No | ❌ No |
| `test-publish.sh` | Release workflow | ❌ No | ⚠️ Yes (package.json) |

---

## Tips

**Before creating a PR:**
```bash
./scripts/test-ci.sh
```

**Before merging to main:**
```bash
./scripts/test-ci.sh
./scripts/test-docker-build.sh
```

**Before triggering release:**
```bash
./scripts/test-publish.sh
# Remember to revert package.json if testing!
git checkout package.json package-lock.json
```

---

## Actual Workflows

These scripts are for **local testing only**. The real CI/CD workflows are:

- **`.github/workflows/ci.yaml`** - Runs on feature branches and PRs
  - Quality checks (lint + test)
  - Build validation
  - No publishing

- **`.github/workflows/release.yaml`** - Runs on manual trigger or tags
  - Quality checks
  - Version calculation
  - **Publishes to npm** (with approval)
  - **Publishes to Docker Hub & GHCR** (with approval)
  - Creates GitHub release
