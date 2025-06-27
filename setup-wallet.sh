#!/bin/bash

# Install Bun
echo "Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# Cek versi bun
echo "Checking Bun version..."
bun --version

# Buka port 8888
echo "Updating apt & installing ufw..."
sudo apt update && sudo apt install ufw -y
echo "Allowing port 8888..."
sudo ufw allow 8888

# Clone repo
echo "Cloning wallet-gen repo..."
git clone https://github.com/octra-labs/wallet-gen
cd wallet-gen || { echo "Failed to cd into wallet-gen"; exit 1; }

# Install dependencies
echo "Installing dependencies..."
bun install

# Build project
echo "Building project..."
bun run build

# Jalankan
echo "Starting wallet generator..."
bun start
