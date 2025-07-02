# Use the official Bun image as the base image
FROM oven/bun:1 as base

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and bun.lockb for dependency installation
COPY package.json bun.lock* ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Create a non-root user for security
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 mcpserver
USER mcpserver

# Expose the port (if your MCP server uses one, adjust as needed)
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production

# Command to run the application
CMD ["bun", "run", "index.ts"]
