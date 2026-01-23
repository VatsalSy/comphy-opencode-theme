#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
THEME_NAME="comphy-gruvbox"
OPENCODE_CONFIG_DIR="${HOME}/.config/opencode"
THEME_DIR="${OPENCODE_CONFIG_DIR}/themes"
THEME_FILE="${THEME_DIR}/${THEME_NAME}.json"
CONFIG_FILE="${OPENCODE_CONFIG_DIR}/opencode.json"

echo -e "${PURPLE}┌─────────────────────────────────────────┐${NC}"
echo -e "${PURPLE}│  CoMPhy Gruvbox Theme for OpenCode     │${NC}"
echo -e "${PURPLE}└─────────────────────────────────────────┘${NC}"
echo ""

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_THEME="${SCRIPT_DIR}/.opencode/themes/${THEME_NAME}.json"

# Check if source theme exists
if [[ ! -f "${SOURCE_THEME}" ]]; then
    echo -e "${RED}✗ Error: Theme file not found at ${SOURCE_THEME}${NC}"
    echo -e "${YELLOW}  Make sure you're running this script from the repository directory.${NC}"
    exit 1
fi

# Create OpenCode config directory if it doesn't exist
if [[ ! -d "${OPENCODE_CONFIG_DIR}" ]]; then
    echo -e "${YELLOW}→ Creating OpenCode config directory...${NC}"
    mkdir -p "${OPENCODE_CONFIG_DIR}"
fi

# Create themes directory if it doesn't exist
if [[ ! -d "${THEME_DIR}" ]]; then
    echo -e "${YELLOW}→ Creating themes directory...${NC}"
    mkdir -p "${THEME_DIR}"
fi

# Copy theme file
echo -e "${YELLOW}→ Installing ${THEME_NAME} theme...${NC}"
cp "${SOURCE_THEME}" "${THEME_FILE}"

if [[ -f "${THEME_FILE}" ]]; then
    echo -e "${GREEN}✓ Theme installed successfully to ${THEME_FILE}${NC}"
else
    echo -e "${RED}✗ Failed to install theme${NC}"
    exit 1
fi

# Check if config file exists
if [[ ! -f "${CONFIG_FILE}" ]]; then
    echo ""
    echo -e "${YELLOW}→ Creating OpenCode config file...${NC}"
    cat > "${CONFIG_FILE}" << 'CONFEOF'
{
  "$schema": "https://opencode.ai/config.json",
  "theme": "comphy-gruvbox"
}
CONFEOF
    echo -e "${GREEN}✓ Config file created with comphy-gruvbox theme${NC}"
else
    # Config exists, ask if user wants to update it
    echo ""
    echo -e "${YELLOW}OpenCode config file already exists.${NC}"
    
    # Check if jq is available for JSON manipulation
    if command -v jq &> /dev/null; then
        # Use jq to check current theme
        CURRENT_THEME=$(jq -r '.theme // "not set"' "${CONFIG_FILE}" 2>/dev/null || echo "unknown")
        echo -e "${YELLOW}Current theme: ${CURRENT_THEME}${NC}"
        
        read -p "Update theme to comphy-gruvbox? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Update theme using jq
            TMP_FILE=$(mktemp)
            jq '.theme = "comphy-gruvbox"' "${CONFIG_FILE}" > "${TMP_FILE}"
            mv "${TMP_FILE}" "${CONFIG_FILE}"
            echo -e "${GREEN}✓ Config updated to use comphy-gruvbox theme${NC}"
        fi
    else
        # jq not available, provide manual instructions
        echo -e "${YELLOW}To use this theme, add or update the following in ${CONFIG_FILE}:${NC}"
        echo -e '  "theme": "comphy-gruvbox"'
    fi
fi

echo ""
echo -e "${GREEN}┌─────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│  Installation Complete!                 │${NC}"
echo -e "${GREEN}└─────────────────────────────────────────┘${NC}"
echo ""
echo -e "${PURPLE}Next steps:${NC}"
echo -e "  1. Restart OpenCode to apply the theme"
echo -e "  2. Enjoy your new Durham purple theme! 🎨"
echo ""
echo -e "${YELLOW}Theme features:${NC}"
echo -e "  • Pure black background (#000000)"
echo -e "  • Durham purple accent (#B347BF)"
echo -e "  • Gruvbox-inspired syntax highlighting"
echo ""
