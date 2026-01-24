# CoMPhy Gruvbox Theme for OpenCode

A dark theme for OpenCode inspired by the Gruvbox color palette, featuring purple as the primary accent color. This theme matches the color scheme used in the companion `comphy-gruvbox.nvim` and `obsidian-comphy-gruvbox` themes.

## Features

- **Pure black background** (#000000) for maximum contrast
- **Purple accent** (#B347BF) for a distinctive look
- **Gruvbox-inspired colors** for syntax highlighting
- **Carefully crafted diff view** with clear add/delete colors
- **Markdown styling** optimized for readability
- **Dark-only theme** optimized for dark mode (light values exist for graceful fallback)

## Color Palette

For detailed color source documentation, see [THEME_PALETTE.md](THEME_PALETTE.md).

### Core Colors

- Background: Pure black (#000000)
- Text: Off-white (#f5f5f0)
- Primary Accent: purple (#B347BF)
- Error: Red (#FB4834)
- Success: Green (#50fa7b)
- Warning: Yellow (#EBCB8B)

### Syntax Highlighting

- Keywords: Yellow
- Functions: Pink
- Strings: Green
- Types: Aqua
- Operators: Orange
- Comments: Gray

## Quick Install

### Option A: Automated Install Script (Recommended)

One-line installation using curl:

```bash
curl -fsSL https://raw.githubusercontent.com/VatsalSy/opencode-comphy-gruvbox/main/install.sh | bash
```

Or download and inspect the script first:

```bash
# Download the script
curl -O https://raw.githubusercontent.com/VatsalSy/opencode-comphy-gruvbox/main/install.sh

# Inspect it (optional but recommended)
cat install.sh

# Make it executable and run
chmod +x install.sh && ./install.sh
```

### Option B: Direct Theme Download

Simple one-liner that downloads the theme directly:

```bash
mkdir -p ~/.config/opencode/themes && \
curl -o ~/.config/opencode/themes/comphy-gruvbox.json \
  https://raw.githubusercontent.com/VatsalSy/opencode-comphy-gruvbox/main/.opencode/themes/comphy-gruvbox.json && \
echo "Theme installed! Add '\"theme\": \"comphy-gruvbox\"' to ~/.config/opencode/opencode.json and restart OpenCode."
```

## Manual Installation

### Method 1: Direct Download from GitHub

```bash
# Create themes directory if needed
mkdir -p ~/.config/opencode/themes

# Download the theme file directly
curl -o ~/.config/opencode/themes/comphy-gruvbox.json \
  https://raw.githubusercontent.com/VatsalSy/opencode-comphy-gruvbox/main/.opencode/themes/comphy-gruvbox.json

# Or use wget
wget -P ~/.config/opencode/themes/ \
  https://raw.githubusercontent.com/VatsalSy/opencode-comphy-gruvbox/main/.opencode/themes/comphy-gruvbox.json
```

Then update your OpenCode configuration (`~/.config/opencode/opencode.json`):

```json
{
  "theme": "comphy-gruvbox"
}
```

Restart OpenCode to apply the theme.

### Method 2: Clone Repository (Recommended)

```bash
# Clone the repo
git clone https://github.com/VatsalSy/opencode-comphy-gruvbox.git

# Copy theme to OpenCode config
cp opencode-comphy-gruvbox/.opencode/themes/comphy-gruvbox.json \
   ~/.config/opencode/themes/
```

### Method 3: Symlink (Auto-updates)

For automatic updates when the theme is modified:

```bash
# Clone the repo first
git clone https://github.com/VatsalSy/opencode-comphy-gruvbox.git

# Create symlink
ln -s "$(pwd)/opencode-comphy-gruvbox/.opencode/themes/comphy-gruvbox.json" \
      ~/.config/opencode/themes/comphy-gruvbox.json

# Pull updates anytime with
cd opencode-comphy-gruvbox && git pull
```

### Method 4: Project-Specific Theme

Place the theme in your project's `.opencode/themes/` directory:

```bash
mkdir -p .opencode/themes
cp path/to/comphy-gruvbox.json .opencode/themes/
```

OpenCode automatically discovers themes in:
- `~/.config/opencode/themes/` (user-wide)
- `<project-root>/.opencode/themes/` (project-specific)
- `./.opencode/themes/` (current directory)

## Companion Themes

This theme is part of the CoMPhy Gruvbox ecosystem:
- **Neovim**: `comphy-gruvbox.nvim`
- **Obsidian**: `obsidian-comphy-gruvbox`
- **OpenCode**: `opencode-comphy-gruvbox` (this theme)

## License

MIT License - See LICENSE file for details
