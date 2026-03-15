#!/bin/bash

#=============================================================================
# Neovim Configuration Setup Script for Ubuntu WSL
#=============================================================================
# This script installs all dependencies needed for your Neovim configuration
# Run this ONCE before using the config on a fresh WSL/VM
#=============================================================================

set -e  # Exit on error

echo "=========================================="
echo "  Neovim Configuration Setup"
echo "=========================================="
echo ""

#=============================================================================
# 1. UPDATE SYSTEM
#=============================================================================
echo "[1/8] Updating system packages..."
sudo apt update && sudo apt upgrade -y

#=============================================================================
# 2. INSTALL NEOVIM 0.11+
#=============================================================================
echo "[2/8] Installing Neovim..."
# Remove old neovim if exists
sudo apt remove -y neovim 2>/dev/null || true

# Install latest stable neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Verify installation
nvim --version | head -n 1

#=============================================================================
# 3. INSTALL BUILD ESSENTIALS
#=============================================================================
echo "[3/8] Installing build tools..."
sudo apt install -y \
    build-essential \
    git \
    curl \
    wget \
    unzip \
    tar \
    gzip \
    ripgrep \
    fd-find

# Create symlink for fd (it's installed as fdfind on Ubuntu)
sudo ln -sf $(which fdfind) /usr/local/bin/fd 2>/dev/null || true

#=============================================================================
# 4. INSTALL NODE.JS & NPM
#=============================================================================
echo "[4/8] Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Verify
node --version
npm --version

#=============================================================================
# 5. INSTALL PYTHON & PIP
#=============================================================================
echo "[5/8] Installing Python and pip..."
sudo apt install -y python3 python3-pip python3-venv

# Verify
python3 --version
pip3 --version

#=============================================================================
# 6. INSTALL LANGUAGE SERVERS
#=============================================================================
echo "[6/8] Installing Language Servers..."

# TypeScript/JavaScript
sudo npm install -g typescript typescript-language-server

# HTML/CSS
sudo npm install -g vscode-langservers-extracted

# JSON
sudo npm install -g vscode-json-languageserver

# Install clangd for C/C++
sudo apt install -y clangd

echo "Language servers installed successfully!"

#=============================================================================
# 7. INSTALL CODE FORMATTERS
#=============================================================================
echo "[7/8] Installing Code Formatters..."

# Prettier (JS/TS/HTML/CSS/JSON/Markdown)
sudo npm install -g prettier

# Stylua (Lua formatter)
cargo install stylua 2>/dev/null || {
    echo "Installing Rust and cargo first..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    cargo install stylua
}

# clang-format (C/C++)
sudo apt install -y clang-format

# google-java-format (Java)
wget https://github.com/google/google-java-format/releases/download/v1.19.2/google-java-format-1.19.2-all-deps.jar -O /tmp/google-java-format.jar
sudo mkdir -p /usr/local/lib/formatters
sudo mv /tmp/google-java-format.jar /usr/local/lib/formatters/
sudo tee /usr/local/bin/google-java-format > /dev/null << 'EOF'
#!/bin/bash
java -jar /usr/local/lib/formatters/google-java-format.jar "$@"
EOF
sudo chmod +x /usr/local/bin/google-java-format

echo "Formatters installed successfully!"

#=============================================================================
# 8. INSTALL JAVA (for Java development)
#=============================================================================
echo "[8/8] Installing Java Development Kit..."
sudo apt install -y default-jdk
java --version

#=============================================================================
# SETUP NEOVIM CONFIG
#=============================================================================
echo ""
echo "=========================================="
echo "Configuration files should be cloned to:"
echo "  ~/.config/nvim"
echo ""
echo "If not already there, run:"
echo "  git clone <your-repo> ~/.config/nvim"
echo "=========================================="

#=============================================================================
# FINAL STEPS
#=============================================================================
echo ""
echo "=========================================="
echo "  Installation Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Close and reopen your terminal"
echo "2. Run: nvim"
echo "3. Wait for lazy.nvim to install plugins"
echo "4. Run: :Copilot setup (if you want GitHub Copilot)"
echo "5. Press <Space>km to see the keymap guide"
echo ""
echo "Installed components:"
echo "  ✓ Neovim $(nvim --version | head -n 1 | awk '{print $2}')"
echo "  ✓ Node.js $(node --version)"
echo "  ✓ Python $(python3 --version | awk '{print $2}')"
echo "  ✓ Language Servers (TS, HTML, CSS, clangd)"
echo "  ✓ Formatters (prettier, stylua, clang-format, google-java-format)"
echo "  ✓ Build tools & utilities"
echo ""
echo "Happy coding! 🚀"
echo ""
