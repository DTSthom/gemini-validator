#!/bin/bash
set -eE

# Gemini Validator - Installation Script
# Installs gemini and gemini-validate CLI tools

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ASCII banner
echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║     🤖 GEMINI VALIDATOR - INSTALLATION             ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""

# Detect script directory (works from any location)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}📂 Installation directory:${NC} $SCRIPT_DIR"
echo ""

# Check for Python 3
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Error: Python 3 not found${NC}"
    echo "Install Python 3 first: sudo apt install python3"
    exit 1
fi

echo -e "${GREEN}✅ Python 3 found:${NC} $(python3 --version)"

# Check if running as root (for /usr/local/bin install)
if [[ $EUID -eq 0 ]]; then
    INSTALL_DIR="/usr/local/bin"
    NEEDS_SUDO=false
else
    # Check if we can write to /usr/local/bin
    if [[ -w /usr/local/bin ]]; then
        INSTALL_DIR="/usr/local/bin"
        NEEDS_SUDO=false
    else
        INSTALL_DIR="/usr/local/bin"
        NEEDS_SUDO=true
        echo -e "${YELLOW}⚠️  Installation to $INSTALL_DIR requires sudo${NC}"
    fi
fi

# Ask for confirmation
echo ""
echo -e "${BLUE}Installation plan:${NC}"
echo "  • gemini          → $INSTALL_DIR/gemini"
echo "  • gemini-validate → $INSTALL_DIR/gemini-validate"
echo ""
read -p "Continue with installation? [Y/n] " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ -n $REPLY ]]; then
    echo "Installation cancelled."
    exit 0
fi

# Install function
install_file() {
    local file=$1
    local dest=$2

    if [[ $NEEDS_SUDO == true ]]; then
        sudo cp "$file" "$dest"
        sudo chmod +x "$dest"
    else
        cp "$file" "$dest"
        chmod +x "$dest"
    fi
}

# Install gemini
echo ""
echo -e "${BLUE}📦 Installing gemini...${NC}"
if install_file "$SCRIPT_DIR/gemini" "$INSTALL_DIR/gemini"; then
    echo -e "${GREEN}✅ Installed gemini${NC}"
else
    echo -e "${RED}❌ Failed to install gemini${NC}"
    exit 1
fi

# Install gemini-validate
echo -e "${BLUE}📦 Installing gemini-validate...${NC}"
if install_file "$SCRIPT_DIR/gemini-validate" "$INSTALL_DIR/gemini-validate"; then
    echo -e "${GREEN}✅ Installed gemini-validate${NC}"
else
    echo -e "${RED}❌ Failed to install gemini-validate${NC}"
    exit 1
fi

# Check API key
echo ""
echo "─────────────────────────────────────────────────────"
echo ""

if [[ -z "$GOOGLE_API_KEY" ]]; then
    echo -e "${YELLOW}⚠️  GOOGLE_API_KEY not set${NC}"
    echo ""
    echo "To use these tools, set your Google API key:"
    echo ""
    echo -e "  ${BLUE}export GOOGLE_API_KEY='your-api-key-here'${NC}"
    echo ""
    echo "Add to ~/.bashrc for persistence:"
    echo ""
    echo -e "  ${BLUE}echo 'export GOOGLE_API_KEY=\"your-key\"' >> ~/.bashrc${NC}"
    echo -e "  ${BLUE}source ~/.bashrc${NC}"
    echo ""
else
    echo -e "${GREEN}✅ GOOGLE_API_KEY is set${NC}"
fi

# Test installation
echo "─────────────────────────────────────────────────────"
echo ""
echo -e "${BLUE}🧪 Testing installation...${NC}"
echo ""

if command -v gemini &> /dev/null; then
    echo -e "${GREEN}✅ gemini command available${NC}"
else
    echo -e "${RED}❌ gemini command not found in PATH${NC}"
    exit 1
fi

if command -v gemini-validate &> /dev/null; then
    echo -e "${GREEN}✅ gemini-validate command available${NC}"
else
    echo -e "${RED}❌ gemini-validate command not found in PATH${NC}"
    exit 1
fi

# Success message
echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║        ✅ INSTALLATION COMPLETE                    ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}Tools installed successfully!${NC}"
echo ""
echo "Quick start:"
echo ""
echo "  gemini 'What is Python?'"
echo "  gemini-validate fact 'Python was released in 1991'"
echo ""
echo "Documentation:"
echo "  cat $SCRIPT_DIR/README.md"
echo ""
