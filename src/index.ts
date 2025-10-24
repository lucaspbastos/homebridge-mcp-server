#!/usr/bin/env node
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";

// Get version from package.json
const __dirname = dirname(fileURLToPath(import.meta.url));
const packageJson = JSON.parse(
    readFileSync(join(__dirname, "../package.json"), "utf-8")
);

// Create server instance
// eslint-disable-next-line @typescript-eslint/no-unused-vars
const server = new McpServer({
    name: packageJson.name,
    version: packageJson.version,
    capabilities: {
        resources: {},
        tools: {},
    },
});