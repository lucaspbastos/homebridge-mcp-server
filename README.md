# Homebridge MCP Server

Experimental MCP server for interfacing with a Homebridge installation.

## Prerequisites

- Node.js 24.x (specified in `.nvmrc`)
- npm (comes with Node.js)

## Installation

### Install Node.js

Using nvm (recommended):
```bash
nvm install
nvm use
```

Or manually install Node.js 24.x from [nodejs.org](https://nodejs.org/).

### Install Dependencies

```bash
npm install
```

## Development

### Build

Compiles TypeScript to the `build/` directory:
```bash
npm run build
```

### Run

Execute the built server:
```bash
npm start
```

### Watch Mode

Automatically rebuild on file changes:
```bash
npm run dev
```

### Linting

Run ESLint checks:
```bash
npm run lint
```

### Testing

Run test suite:
```bash
npm test
```

## Docker

### Build Docker Image

Local testing:
```bash
./scripts/test-docker-build.sh
```

This builds a Docker image tagged as `homebridge-mcp-server:local`.

### Run Docker Container

```bash
docker run --rm homebridge-mcp-server:local
```

## Local Testing Scripts

The `scripts/` directory contains utilities for testing CI/CD workflows locally:

- **`test-ci.sh`** - Simulates CI quality checks (lint + test + build)
- **`test-docker-build.sh`** - Builds Docker image locally
- **`test-publish.sh`** - Simulates release workflow with version bumping

See `scripts/README.md` for detailed usage instructions.

## Installation as CLI Tool

Once published to npm, install globally:
```bash
npm install -g homebridge-mcp-server
```

Or run directly with npx:
```bash
npx homebridge-mcp-server
```

## CI/CD Workflows

### Continuous Integration

Runs on feature branches and pull requests:
- Quality checks (lint + test)
- Build validation
- Automated via `.github/workflows/ci.yaml`

### Release Workflow

Manual or tag-triggered releases:
- Version calculation and package updates
- Publishes to npm (with approval)
- Builds and publishes Docker images to GHCR and Docker Hub (with approval)
- Creates GitHub releases
- Automated via `.github/workflows/release.yaml`

## Project Structure

```
.
├── src/                  # TypeScript source files
├── build/                # Compiled JavaScript (git-ignored)
├── scripts/              # Local testing utilities
├── .github/workflows/    # CI/CD workflows
├── containers/           # Docker development environment
└── Dockerfile            # Multi-stage Alpine build
```

## License

ISC
