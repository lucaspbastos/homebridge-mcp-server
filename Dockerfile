# Build stage - use node alpine image
# Note: Pass NODE_VERSION via --build-arg (should match .nvmrc)
ARG NODE_VERSION=24
FROM node:${NODE_VERSION}-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install production dependencies only
RUN npm ci --omit=dev

# Copy built files
COPY build ./build

# Runtime stage - use minimal alpine node image
ARG NODE_VERSION=24
FROM node:${NODE_VERSION}-alpine

WORKDIR /app

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copy only what we need from builder
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/build ./build
COPY --from=builder --chown=nodejs:nodejs /app/package.json ./

# Switch to non-root user
USER nodejs

# Expose port if needed (uncomment and adjust as needed)
# EXPOSE 3000

# Run the MCP server
CMD ["node", "build/index.js"]
