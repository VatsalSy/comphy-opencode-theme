# OpenCode Comphy Gruvbox Theme

A Gruvbox-inspired color theme for OpenCode IDE.

## Structure

```
opencode-comphy-gruvbox/
├── theme.json       # Main theme definition
├── README.md        # Documentation
└── CLAUDE.md        # This file
```

## Development

The theme is defined in a JSON file following OpenCode's theme specification.

```bash
# Test theme locally
cp theme.json ~/.config/opencode/themes/comphy-gruvbox.json

# Reload OpenCode to see changes
```

## Guidelines

- Follow Gruvbox color palette (warm variant)
- Maintain WCAG AA contrast ratios for readability
- Use semantic color naming in theme.json
- Test with scientific code (Python, C, LaTeX)
- Optimize for terminal and editor views
