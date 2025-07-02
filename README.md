# 🚀 Zerodha Trading MCP Server -- Claude

<div align="center">

![Trading](https://img.shields.io/badge/Trading-Zerodha-green)
![MCP](https://img.shields.io/badge/Protocol-MCP-blue)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?logo=typescript&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-43853D?logo=node.js&logoColor=white)

*A powerful Model Context Protocol (MCP) server that enables AI models to interact seamlessly with the Zerodha trading platform*

</div>

## 📋 Table of Contents

- [✨ Features](#-features)
- [🎯 What is MCP?](#-what-is-mcp)
- [⚡ Quick Start](#-quick-start)
- [📦 Installation](#-installation)
- [🐳 Docker Installation](#-docker-installation-alternative)
- [⚙️ Configuration](#️-configuration)
- [🔧 Claude Desktop Setup](#-claude-desktop-setup)
- [📖 API Reference](#-api-reference)
- [🛠️ Development](#️-development)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [⚠️ Disclaimer](#️-disclaimer)

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔐 **Secure Authentication** | Robust authentication with Zerodha API using official KiteConnect SDK |
| 📊 **Portfolio Management** | Real-time access to your complete portfolio holdings and valuations |
| 📈 **Position Tracking** | Monitor open positions with live P&L calculations |
| 💹 **Order Execution** | Place buy/sell orders with market/limit options |
| 👤 **Profile Access** | Retrieve comprehensive user profile and account information |
| 🔄 **Real-time Data** | Live market data and portfolio updates |
| 🛡️ **Type Safety** | Built with TypeScript and Zod validation for reliability |

## 🎯 What is MCP?

The **Model Context Protocol (MCP)** is a standardized way for AI models to interact with external systems and APIs. This server acts as a bridge between AI assistants (like Claude) and the Zerodha trading platform, enabling natural language trading operations.

## ⚡ Quick Start

### Prerequisites

Before you begin, ensure you have:

- ✅ **Node.js** (v16 or higher) - [Download here](https://nodejs.org/)
- ✅ **Zerodha Trading Account** - [Sign up here](https://zerodha.com/)
- ✅ **Zerodha API Access** - [Get API credentials](https://kite.trade/)
- ✅ **Bun Runtime** (recommended) - [Install here](https://bun.sh/)

## 📦 Installation

### Step 1: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/gamandeepsingh/zerodha-claude-mcp.git

# Navigate to the project directory
cd zerodha-claude-mcp
```

### Step 2: Install Dependencies

Choose your preferred package manager:

```bash
# Using npm
npm install

# Using bun (recommended for better performance)
bun install

# Using yarn
yarn install
```

### Step 3: Environment Setup

Create a `.env` file in the root directory:

```bash
# Copy the example environment file
cp .env.example .env
```

Add your Zerodha credentials to the `.env` file:

```env
# Zerodha API Configuration
KITE_API_KEY=your_api_key_here
KITE_SECRET_KEY=your_secret_key_here
REQUEST_TOKEN=your_request_token_here
ACCESS_TOKEN=your_access_token_here

# Optional: Debug mode
DEBUG=false
```

> 💡 **Pro Tip**: You can get your API credentials from the [Kite Connect Developer Console](https://developers.kite.trade/)

## 🐳 Docker Installation (Alternative)

For a containerized setup, you can use Docker to run the MCP server:

### Prerequisites for Docker

- ✅ **Docker** - [Install Docker](https://docs.docker.com/get-docker/)
- ✅ **Docker Compose** (optional, for easier management) - Usually included with Docker Desktop

### Option 1: Using Docker Compose (Recommended)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/gamandeepsingh/zerodha-claude-mcp.git
   cd zerodha-claude-mcp
   ```

2. **Create environment file**:
   ```bash
   # Create .env file with your credentials
   cp .env.example .env
   ```

3. **Edit the .env file** with your Zerodha credentials:
   ```env
   KITE_API_KEY=your_api_key_here
   KITE_SECRET_KEY=your_secret_key_here
   REQUEST_TOKEN=your_request_token_here
   ACCESS_TOKEN=your_access_token_here
   DEBUG=false
   ```

4. **Build and run with Docker Compose**:
   ```bash
   # Build and start the container
   docker-compose up --build
   
   # Run in detached mode (background)
   docker-compose up -d --build
   ```

5. **Stop the container**:
   ```bash
   docker-compose down
   ```

### Option 2: Using Docker directly

1. **Build the Docker image**:
   ```bash
   docker build -t zerodha-claude-mcp .
   ```

2. **Run the container**:
   ```bash
   docker run -d \
     --name zerodha-mcp \
     -e KITE_API_KEY=your_api_key \
     -e KITE_SECRET_KEY=your_secret_key \
     -e REQUEST_TOKEN=your_request_token \
     -e ACCESS_TOKEN=your_access_token \
     zerodha-claude-mcp
   ```

### Docker Management Commands

```bash
# View running containers
docker ps

# View logs
docker logs zerodha-mcp

# Stop the container
docker stop zerodha-mcp

# Remove the container
docker rm zerodha-mcp

# Remove the image
docker rmi zerodha-claude-mcp
```

### Claude Desktop Configuration with Docker

When using Docker, update your `claude_desktop_config.json` to point to the containerized version:

```json
{
  "mcpServers": {
    "zerodha-trading": {
      "command": "docker",
      "args": ["exec", "-i", "zerodha-mcp", "bun", "run", "index.ts"],
      "env": {
        "KITE_API_KEY": "your_actual_api_key",
        "KITE_SECRET_KEY": "your_actual_secret_key",
        "REQUEST_TOKEN": "your_actual_request_token",
        "ACCESS_TOKEN": "your_actual_access_token"
      }
    }
  }
}
```

> ⚠️ **Note**: Make sure your Docker container is running before starting Claude Desktop when using this configuration.

## ⚙️ Configuration

### Getting Zerodha API Credentials

1. **Sign up** for a Kite Connect app at [developers.kite.trade](https://developers.kite.trade/)
2. **Create a new app** and note down your `api_key` and `api_secret`
3. **Generate tokens** using the authentication flow
4. **Add credentials** to your `.env` file

### Token Generation Process

```bash
# Step 1: Get the login URL
curl "https://kite.trade/connect/login?api_key=your_api_key&v=3"

# Step 2: After login, extract request_token from redirect URL
# Step 3: Generate access_token using the request_token
```

## 🔧 Claude Desktop Setup

To integrate this MCP server with Claude Desktop, follow these steps:

### Step 1: Locate Claude Desktop Config

Find your `claude_desktop_config.json` file:

- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`
- **Linux**: `~/.config/Claude/claude_desktop_config.json`

### Step 2: Add MCP Server Configuration

Add the following to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "zerodha-trading": {
      "command": "bun",
      "args": ["run", "/absolute/path/to/your/index.ts"],
      "env": {
        "KITE_API_KEY": "your_actual_api_key",
        "KITE_SECRET_KEY": "your_actual_secret_key", 
        "REQUEST_TOKEN": "your_actual_request_token",
        "ACCESS_TOKEN": "your_actual_access_token"
      }
    }
  }
}
```

### Step 3: Restart Claude Desktop

After saving the configuration, restart Claude Desktop to load the MCP server.

### Alternative: Using Node.js

If you prefer Node.js over Bun:

```json
{
  "mcpServers": {
    "zerodha-trading": {
      "command": "node",
      "args": ["--loader", "ts-node/esm", "/absolute/path/to/your/index.ts"],
      "env": {
        "KITE_API_KEY": "your_actual_api_key",
        "KITE_SECRET_KEY": "your_actual_secret_key",
        "REQUEST_TOKEN": "your_actual_request_token", 
        "ACCESS_TOKEN": "your_actual_access_token"
      }
    }
  }
}
```

> ⚠️ **Important**: 
> - Replace `/absolute/path/to/your/index.ts` with the actual path to your project
> - Use your real Zerodha API credentials
> - Ensure the path uses forward slashes even on Windows

## 📖 API Reference

The MCP server exposes the following tools for AI interaction:

### 👤 Profile Operations

#### `get-profile`
Retrieves comprehensive user profile information.

```typescript
// Usage in Claude
"Can you show me my Zerodha profile?"

// Returns
{
  user_id: string,
  user_name: string,
  email: string,
  user_type: string,
  broker: string,
  // ... additional profile data
}
```

### 💰 Portfolio & Positions

#### `show-portfolio`
Displays complete portfolio holdings with current valuations.

```typescript
// Usage in Claude  
"What's in my portfolio right now?"

// Returns detailed holdings with:
// - Stock symbols and quantities
// - Current market prices
// - P&L calculations
// - Total portfolio value
```

#### `show-positions`
Shows all open positions with live P&L.

```typescript
// Usage in Claude
"Show me my current trading positions"

// Returns active positions with:
// - Entry prices and quantities
// - Current market prices  
// - Unrealized P&L
// - Position status
```

### 📈 Trading Operations

#### `buy-stock`
Places a buy order for specified stock and quantity.

```typescript
// Parameters
{
  stock: string,    // Stock symbol (e.g., "RELIANCE", "TCS")
  quantity: number  // Number of shares to buy
}

// Usage in Claude
"Buy 10 shares of RELIANCE"
"Purchase 50 TCS stocks"
```

#### `sell-stock`  
Places a sell order for specified stock and quantity.

```typescript
// Parameters
{
  stock: string,    // Stock symbol (e.g., "RELIANCE", "TCS") 
  quantity: number  // Number of shares to sell
}

// Usage in Claude
"Sell 5 shares of HDFC Bank"
"Exit my position in Infosys"
```

### 🔍 Example Conversations

Here are some natural language examples you can use with Claude:

```
🗣️ "What's my current portfolio value?"
🗣️ "Buy 25 shares of ITC"  
🗣️ "Show me all my losing positions"
🗣️ "What's my profile information?"
🗣️ "Sell half of my Wipro holdings"
```

## 🛠️ Development

### Technology Stack

| Technology | Purpose | Version |
|------------|---------|---------|
| **TypeScript** | Type-safe development | ^5.0.0 |
| **KiteConnect** | Zerodha API integration | Latest |
| **MCP SDK** | Model Context Protocol | Latest |
| **Zod** | Runtime type validation | ^3.0.0 |
| **Bun** | Fast runtime & package manager | ^1.0.0 |

### Project Structure

```
zerodha-claude-mcp/
├── 📄 index.ts              # MCP server entry point
├── 📄 trade.ts              # Trading logic and API calls  
├── 📄 package.json          # Dependencies and scripts
├── 📄 tsconfig.json         # TypeScript configuration
├── 📄 .env                  # Environment variables
├── 📄 README.md             # Documentation
├── 📄 bun.lock             # Lock file
├── 🐳 Dockerfile           # Docker image configuration
├── 🐳 docker-compose.yml   # Docker Compose setup
└── 📄 .dockerignore        # Docker ignore rules
```

### Local Development

1. **Clone and setup** (if not already done):
   ```bash
   git clone https://github.com/gamandeepsingh/zerodha-claude-mcp.git
   cd zerodha-claude-mcp
   bun install
   ```

2. **Start development server**:
   ```bash
   # Development mode with auto-reload
   bun run dev
   
   # Production mode
   bun run start
   ```

3. **Run tests** (if available):
   ```bash
   bun test
   ```

### Adding New Features

To add new trading tools:

1. **Define the tool** in your MCP server
2. **Add Zod schema** for parameter validation  
3. **Implement handler** using KiteConnect API
4. **Update documentation** in this README

### Debugging

Enable debug mode by setting `DEBUG=true` in your `.env` file:

```env
DEBUG=true
```

This will provide detailed logging of API calls and responses.

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Ways to Contribute

- 🐛 **Bug Reports**: Found a bug? [Open an issue](https://github.com/gamandeepsingh/zerodha-claude-mcp/issues)
- ✨ **Feature Requests**: Have an idea? [Start a discussion](https://github.com/gamandeepsingh/zerodha-claude-mcp/discussions)
- 📝 **Documentation**: Improve docs, add examples
- 🔧 **Code**: Fix bugs, add features, improve performance

### Development Workflow

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** your changes: `git commit -m 'Add amazing feature'`
4. **Push** to the branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request

### Code Standards

- ✅ Use TypeScript for all new code
- ✅ Follow existing code style
- ✅ Add tests for new features
- ✅ Update documentation
- ✅ Ensure all tests pass

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for full details.

### MIT License Summary

```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

## ⚠️ Disclaimer

> **IMPORTANT**: This project is for educational and development purposes only.

### Risk Warning

- 📊 **Trading Risk**: Trading in financial markets involves substantial risk of loss
- 💰 **Capital Risk**: Never trade with money you cannot afford to lose
- 🔍 **Due Diligence**: Always conduct your own research before making trading decisions
- 🤖 **AI Limitations**: AI-generated trading decisions should not be followed blindly
- 📈 **Market Volatility**: Past performance does not guarantee future results

### Best Practices

1. **Start Small**: Test with small amounts first
2. **Paper Trading**: Use Zerodha's paper trading feature initially  
3. **Risk Management**: Set stop-losses and position limits
4. **Stay Informed**: Keep up with market news and regulations
5. **Continuous Learning**: Educate yourself about trading strategies

### Support

- 📚 **Documentation**: Check this README and inline code comments
- 💬 **Discussions**: Join [GitHub Discussions](https://github.com/gamandeepsingh/zerodha-claude-mcp/discussions)
- 🐛 **Issues**: Report bugs via [GitHub Issues](https://github.com/gamandeepsingh/zerodha-claude-mcp/issues)
- 📧 **Email**: Contact the maintainers for specific questions

---

<div align="center">

**Made with ❤️ for the trading community**

⭐ **Star this repo** if you find it useful! | 🍴 **Fork it** to customize for your needs

</div>

