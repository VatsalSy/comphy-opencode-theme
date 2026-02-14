#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
THEME_NAME="comphy-opencode-theme"
OPENCODE_CONFIG_DIR="${HOME}/.config/opencode"
THEME_DIR="${OPENCODE_CONFIG_DIR}/themes"
THEME_FILE="${THEME_DIR}/${THEME_NAME}.json"
CONFIG_FILE="${OPENCODE_CONFIG_DIR}/opencode.json"
TEMP_THEME=""
TMP_FILE=""

cleanup_temp_files() {
    if [[ -n "${TMP_FILE}" ]]; then
        rm -f "${TMP_FILE}"
    fi

    if [[ -n "${TEMP_THEME}" ]]; then
        rm -f "${TEMP_THEME}"
    fi
}

trap 'cleanup_temp_files' EXIT

echo -e "${PURPLE}┌─────────────────────────────────────────┐${NC}"
echo -e "${PURPLE}│  CoMPhy OpenCode Theme                  │${NC}"
echo -e "${PURPLE}└─────────────────────────────────────────┘${NC}"
echo ""

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_THEME="${SCRIPT_DIR}/.opencode/themes/${THEME_NAME}.json"
REMOTE_THEME_URL="https://raw.githubusercontent.com/VatsalSy/comphy-opencode-theme/main/.opencode/themes/${THEME_NAME}.json"

# Check if source theme exists locally, otherwise download from GitHub
if [[ ! -f "${SOURCE_THEME}" ]]; then
    echo -e "${YELLOW}→ Theme not found locally, downloading from GitHub...${NC}"
    # Create temp file for download
    TEMP_THEME=$(mktemp)

    if curl -fsSL "${REMOTE_THEME_URL}" -o "${TEMP_THEME}" 2>/dev/null; then
        SOURCE_THEME="${TEMP_THEME}"
        echo -e "${GREEN}✓ Downloaded theme from GitHub${NC}"
    else
        echo -e "${RED}✗ Error: Could not download theme from GitHub${NC}"
        echo -e "${YELLOW}  Check your internet connection or clone the repository:${NC}"
        echo -e "${YELLOW}  git clone https://github.com/VatsalSy/comphy-opencode-theme.git${NC}"
        exit 1
    fi
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
  "theme": "comphy-opencode-theme"
}
CONFEOF
    echo -e "${GREEN}✓ Config file created with comphy-opencode-theme theme${NC}"
else
    # Config exists, ask if user wants to update it
    echo ""
    echo -e "${YELLOW}OpenCode config file already exists.${NC}"
    
    # Check if jq is available for JSON manipulation
    if command -v jq &> /dev/null; then
        # Use jq to check current theme
        CURRENT_THEME=$(jq -r '.theme // "not set"' "${CONFIG_FILE}" 2>/dev/null || echo "unknown")
        echo -e "${YELLOW}Current theme: ${CURRENT_THEME}${NC}"
        
        if [[ -t 0 ]]; then
            read -p "Update theme to comphy-opencode-theme? [y/N] " -n 1 -r < /dev/tty
            echo
        else
            REPLY="n"
        fi
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Create backup before modifying config
            BACKUP_FILE="${CONFIG_FILE}.bak.$(date +%Y%m%d_%H%M%S)"
            if ! cp "${CONFIG_FILE}" "${BACKUP_FILE}"; then
                echo -e "${RED}✗ Failed to create backup${NC}"
                exit 1
            fi
            echo -e "${YELLOW}→ Backup created: ${BACKUP_FILE}${NC}"

            # Update theme using jq with temp file cleanup
            TMP_FILE=$(mktemp)
            if JQ_ERROR=$(jq '.theme = "comphy-opencode-theme"' "${CONFIG_FILE}" 2>&1 > "${TMP_FILE}"); then
                mv "${TMP_FILE}" "${CONFIG_FILE}"
                echo -e "${GREEN}✓ Config updated to use comphy-opencode-theme theme${NC}"
            else
                rm -f "${TMP_FILE}"
                echo -e "${RED}✗ Failed to update config (invalid JSON or jq error)${NC}"
                if [[ -n "${JQ_ERROR}" ]]; then
                    echo -e "${YELLOW}jq error output:${NC}"
                    printf '%s\n' "${JQ_ERROR}"
                fi
                echo -e "${YELLOW}To use this theme, add or update the following in ${CONFIG_FILE}:${NC}"
                echo -e '  "theme": "comphy-opencode-theme"'
            fi
        fi
    else
        # jq not available, provide manual instructions
        echo -e "${YELLOW}To use this theme, add or update the following in ${CONFIG_FILE}:${NC}"
        echo -e '  "theme": "comphy-opencode-theme"'
    fi
fi

echo ""
echo -e "${GREEN}┌─────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│  Installation Complete!                 │${NC}"
echo -e "${GREEN}└─────────────────────────────────────────┘${NC}"
echo ""
echo -e "${PURPLE}Next steps:${NC}"
echo -e "  1. Restart OpenCode to apply the theme"
echo -e "  2. Enjoy your new purple theme! 🎨"
echo ""
echo -e "${YELLOW}Theme features:${NC}"
echo -e "  • Pure black background (#000000)"
echo -e "  • Purple accent (#B347BF)"
echo -e "  • Gruvbox-inspired syntax highlighting"
echo ""
