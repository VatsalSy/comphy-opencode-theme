# Theme Palette Documentation

This document details the color sources for the CoMPhy OpenCode theme, showing which colors come from the original Gruvbox palette and which are borrowed from other sources or custom-defined.

## Color Source Attribution

### Base Colors (Gruvbox-inspired)

These colors are Gruvbox-inspired or modified variants from the palette:

| Color Key | Hex Code | Usage |
|-----------|----------|-------|
| `bg0` | #000000 | Inspired by Gruvbox hard variant; set to pure black (`#000000`) for OLED optimization |
| `bg1` | #1a1a1a | Panel backgrounds |
| `bg2` | #292929 | Element backgrounds |
| `bg3` | #404040 | Subtle borders |
| `fg0` | #f5f5f0 | Primary text |
| `fg1` | #f0f0eb | Secondary text |
| `fgMuted` | #CCCCCC | Muted text, comments |
| `yellow` | #EBCB8B | Keywords, emphasis (Nord-influenced Gruvbox yellow) |
| `orange` | #FE8018 | Operators, strong emphasis |
| `border` | #3c3836 | Default borders |

### Dracula Colors

These colors are borrowed from the Dracula theme for vibrant syntax highlighting:

| Color Key | Hex Code | Usage |
|-----------|----------|-------|
| `green` | #50fa7b | Success, strings, diff additions |
| `pink` | #ff79c6 | Functions, images |
| `purpleLight` | #bd93f9 | Secondary accent, links |

### Nord Colors

These colors are inspired by the Nord theme palette:

| Color Key | Hex Code | Usage |
|-----------|----------|-------|
| `greenSoft` | #A3BE8C | Block quotes |
| `yellow` | #EBCB8B | Keywords (shared with Gruvbox) |
| `blue` | #88C0D0 | Info, links, diff headers |

### Custom Colors

These colors are custom-defined for this theme:

| Color Key | Hex Code | Usage | Notes |
|-----------|----------|-------|-------|
| `purple` | #B347BF | Primary accent | Purple - signature color |
| `red` | #FB4834 | Errors, diff deletions | Gruvbox-inspired but adjusted |
| `aqua` | #81D2CE | Types, numbers, code | Gruvbox aqua variant |
| `selection` | #392c4b | Text selection | Purple-tinted dark |
| `cursor` | #9b4fa0 | Input cursor | Lighter purple |
| `diffAddBg` | #0f2f17 | Diff addition background | Dark green tint |
| `diffDelBg` | #301010 | Diff deletion background | Dark red tint |

## Design Philosophy

The theme combines:

1. **Gruvbox foundation**: Warm, retro-inspired base colors for comfort during long coding sessions
2. **Dracula vibrancy**: Bright accent colors for better syntax distinction
3. **Nord softness**: Gentle blues and greens for non-critical UI elements
4. **Purple**: Distinctive primary accent color for CoMPhy Lab branding

This combination creates a cohesive dark theme optimized for scientific code (Python, C, LaTeX) with excellent readability and visual hierarchy.

## Compatibility Notes

- This is a **dark-only theme**. Light mode values in the theme file mirror dark mode for graceful fallback, but the theme is not optimized for light backgrounds.
- Pure black (#000000) background provides maximum contrast for OLED displays.
- Most text and accent tokens meet WCAG AA contrast ratios; `border` and `subtle-border` (mapped to `bg3`) are decorative and fall below 4.5:1.

## References

- [Gruvbox](https://github.com/morhetz/gruvbox)
- [Dracula](https://draculatheme.com/)
- [Nord](https://www.nordtheme.com/)
- [Durham University Brand Guidelines](https://www.durham.ac.uk/brand/)
