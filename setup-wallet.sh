#!/bin/bash

set -e  # Stop script kalau ada error

# Cek apakah Bun sudah terinstall
if command -v bun &> /dev/null; then
    echo "✅ Bun sudah terinstall, skip install."
else
    echo "🔧 Installing Bun..."
    curl -fsSL https://bun.sh/install | bash

    # Tambah PATH sementara untuk sesi ini
    export PATH="$HOME/.bun/bin:$PATH"
fi

# Pastikan PATH tetap aman untuk sesi ini
export PATH="$HOME/.bun/bin:$PATH"

# Cek versi bun
echo "🔍 Mengecek versi Bun..."
bun --version

# Buka port 8888
echo "🌐 Mengatur firewall..."
sudo apt update && sudo apt install ufw -y
sudo ufw allow 8888

# Clone repo wallet-gen
echo "📦 Cloning repository wallet-gen..."
git clone https://github.com/octra-labs/wallet-gen
cd wallet-gen || { echo "❌ Gagal masuk ke folder wallet-gen"; exit 1; }

# Install dependencies
echo "📁 Menginstall dependencies..."
bun install

# Build project
echo "⚙️  Build project..."
bun run build

# Jalankan
echo "🚀 Menjalankan wallet generator..."
bun start
