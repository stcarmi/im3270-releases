#!/bin/bash
# IM3270 Installation Script for Ubuntu/WSL2
# Usage: curl -fsSL https://raw.githubusercontent.com/stcarmi/im3270-releases/main/scripts/install-ubuntu.sh | bash

set -e

# Colors for output
YELLOW='\033[1;33m'
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo "=== IM3270 Installation for Ubuntu/WSL2 ==="
echo
echo -e "${YELLOW}LICENSE AGREEMENT${NC}"
echo -e "${YELLOW}By installing this software, you agree to the End User License Agreement.${NC}"
echo -e "${YELLOW}View full license: https://im3270.infomanta.com/about/license${NC}"
echo -e "${YELLOW}Privacy Policy: https://im3270.infomanta.com/about/privacy${NC}"
echo

# Check/install s3270 4.x
echo "Checking s3270..."
S3270_VERSION=$(s3270 -version 2>&1 | grep -oP 'v\K[0-9]+\.[0-9]+' || echo "0")
S3270_MAJOR=$(echo "$S3270_VERSION" | cut -d. -f1)

if [ "$S3270_MAJOR" -lt 4 ] 2>/dev/null; then
    echo -e "${RED}s3270 4.x is required. Distro packages install outdated v3.x.${NC}"
    echo "Building s3270 4.x from source..."
    sudo apt update
    sudo apt install -y gcc make libssl-dev wget
    cd /tmp
    rm -rf suite3270-*
    wget -q https://x3270.bgp.nu/download/04.04/suite3270-4.4ga6-src.tgz
    tar xzf suite3270-4.4ga6-src.tgz
    cd suite3270-4.4
    ./configure --quiet && make s3270 --quiet && sudo make install.s3270
    cd /tmp && rm -rf suite3270-*
    echo -e "${GREEN}s3270 4.x installed successfully${NC}"
else
    echo -e "${GREEN}s3270 $S3270_VERSION found${NC}"
fi

# Install FUSE for AppImage
sudo apt install -y fuse libfuse2 2>/dev/null || true

# Install WSL2 Electron dependencies
if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "WSL2 detected - installing Electron dependencies..."
    sudo apt install -y libnspr4 libnss3 libatk1.0-0 libatk-bridge2.0-0 \
                         libcups2 libdrm2 libgbm1 libgtk-3-0 libxkbcommon0 \
                         libxcomposite1 libxdamage1 libxrandr2 2>/dev/null || true
    sudo apt install -y libasound2t64 2>/dev/null || sudo apt install -y libasound2 2>/dev/null || true
fi

# Create application directory
INSTALL_DIR="$HOME/.local/share/im3270"
mkdir -p "$INSTALL_DIR"
mkdir -p "$HOME/.local/bin"

# Download AppImage
echo "Downloading IM3270..."
RELEASE_URL="https://github.com/stcarmi/im3270-releases/releases/latest/download/IM3270-0.43.14.AppImage"
curl -L -o "$INSTALL_DIR/IM3270.AppImage" "$RELEASE_URL" || {
    echo -e "${RED}Failed to download IM3270. Check https://github.com/stcarmi/im3270-releases/releases${NC}"
    exit 1
}

chmod +x "$INSTALL_DIR/IM3270.AppImage"

# Create launcher script
cat > "$HOME/.local/bin/im3270" << 'EOF'
#!/bin/bash
~/.local/share/im3270/IM3270.AppImage "$@"
EOF
chmod +x "$HOME/.local/bin/im3270"

# Add to PATH if needed
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "Added ~/.local/bin to PATH (restart terminal or run: source ~/.bashrc)"
fi

# Create desktop entry (for WSLg)
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/im3270.desktop" << EOF
[Desktop Entry]
Name=IM3270
Comment=3270 Terminal Emulator
Exec=$HOME/.local/bin/im3270
Terminal=false
Type=Application
Categories=Utility;TerminalEmulator;
EOF

echo
echo "=== Installation Complete ==="
echo "Run 'im3270' to start the application"
echo
echo "For WSL2: Make sure WSLg is enabled (Windows 11) or run an X server (Windows 10)"
