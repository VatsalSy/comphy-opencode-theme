# OpenCode CoMPhy Gruvbox Theme - Agent Guide

This repository ships a static OpenCode theme plus an install script.
There is no build system and no automated tests; validate changes
manually by loading the theme in OpenCode.

## Repository Layout

- `.opencode/themes/comphy-gruvbox.json`: Source of truth for the theme.
- `THEME_PALETTE.md`: Color sources and attribution notes.
- `README.md`: User-facing install and usage documentation.
- `install.sh`: Automated installer for the theme.
- `.opencode/package.json`: OpenCode plugin dependency (do not edit
  unless required for OpenCode tooling).

## Build, Lint, Test

There is no build or test runner in this repo. Treat the JSON theme
file as the source artifact and validate it manually.

Build

- None. Editing `.opencode/themes/comphy-gruvbox.json` is the build.

Lint / Format

- No lint configuration is present.
- Optional JSON sanity check (requires `jq`):
  `jq -e . .opencode/themes/comphy-gruvbox.json`
- Optional JSON sanity check (Python):
  `python -m json.tool .opencode/themes/comphy-gruvbox.json > /dev/null`

Tests

- No automated tests are defined.
- Manual validation is required (see below).
- Single test: not applicable (no test runner).

Manual Validation

- Local install: `./install.sh`
- Direct copy: `cp .opencode/themes/comphy-gruvbox.json \
  ~/.config/opencode/themes/comphy-gruvbox.json`
- Restart OpenCode and confirm the theme loads without errors.
- Check key views: editor, diff, markdown preview, and prompts.

## Theme Design Guidelines

- Follow the Gruvbox-inspired warm palette with Durham purple accents.
- Maintain WCAG AA contrast for text and UI elements.
- Keep the theme dark-only; `dark` and `light` values should match.
- Use semantic tokens (primary, error, diffAdded) instead of raw values.
- Update `THEME_PALETTE.md` when adding or changing colors.
- Update `README.md` if the palette or install steps change.

## JSON Style and Structure

- Indentation is 2 spaces; no tabs.
- Keep all color hex values in `defs`; never inline hex in `theme`.
- Use 6-digit hex codes; avoid shorthand `#abc`.
- Preserve existing casing of hex values (do not normalize unless
  editing the specific color).
- Use lower camelCase keys (for example `diffAddedBg`).
- Keep `defs` ordered: base background and text, accents, state colors,
  then special UI colors.
- Keep `theme` ordered by functional grouping: primary, status colors,
  text/background, borders, diffs, markdown, syntax, inputs.
- Keep both `dark` and `light` entries, even when identical.

## Theme Editing Workflow

- Start with `.opencode/themes/comphy-gruvbox.json` as the source file.
- Add new colors only to `defs`; reference them by name in `theme`.
- Update `THEME_PALETTE.md` with source and rationale for new colors.
- Update `README.md` when palette, usage, or install steps change.
- Run an optional JSON sanity check before installing.
- Install locally using `./install.sh` or direct copy.
- Restart OpenCode after installing to reload the theme.
- Validate the theme in editor, diff, markdown preview, and prompts.
- Keep changes scoped; avoid touching vendor artifacts.

## Theme Review Checklist

- Text vs background has strong contrast; textMuted stays legible.
- Primary and secondary accents are readable in UI and prompts.
- Selection and cursor stand out on `bg0`.
- Diff added and removed backgrounds are dark enough to read.
- Diff line numbers and hunk headers remain visible.
- Markdown headings, links, and inline code are distinct.
- Syntax categories remain easy to distinguish at a glance.
- Inputs show clear borders and active border state.
- Borders and panels provide depth without overpowering content.
- `dark` and `light` entries remain identical for dark-only behavior.

## Documentation Conventions

- Use Markdown headings and short, direct paragraphs.
- Wrap commands in fenced code blocks with `bash` info strings.
- Keep list punctuation and casing consistent within a section.
- Avoid Unicode symbols in docs unless required by the theme.
- Keep palette references and links current.
- Prefer sentence case for list items.

## OpenCode Schema Notes

- Keep `$schema` at the top of the JSON file.
- `defs` must contain only hex values.
- `theme` entries should reference keys from `defs`.
- Do not remove `dark` or `light` entries.
- Prefer editing existing tokens before adding new ones.
- Verify any new keys match the OpenCode schema.

## Shell Script Style (install.sh)

- Use `#!/usr/bin/env bash` and `set -e` at top of scripts.
- Use 4-space indentation to match existing script style.
- Prefer `[[ ... ]]` for tests and quote all variables.
- Use uppercase `SNAKE_CASE` for constants and global vars.
- Clean up temp files with `trap` and explicit `rm -f`.
- Provide clear, user-facing errors and exit non-zero on failure.
- Keep the script idempotent and avoid destructive operations.

## Naming Conventions

- Theme id uses `kebab-case`: `comphy-gruvbox`.
- JSON keys use lower camelCase.
- Bash variables use uppercase snake case.
- New files should follow existing naming patterns (kebab-case for
  scripts, uppercase for docs like `THEME_PALETTE.md`).

## Error Handling Expectations

- JSON: keep valid JSON at all times; validate with `jq` or Python if
  making large edits.
- Shell: prefer early exits when required files or commands are missing.
- Avoid silent failures; provide actionable messages for the user.

## Imports and Types (If JS/TS Is Added)

- No JS/TS code exists today; apply this only if introducing it.
- Use ESM `import` syntax and group imports: builtins, external, local.
- Prefer explicit exported types; avoid `any` in TypeScript.
- Keep formatting consistent with 2-space indentation.

## Files to Avoid Editing

- `.opencode/node_modules/` and lockfiles are vendor artifacts.
- `.git/` is repository metadata.

## Cursor and Copilot Rules

- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md`
  files are present in this repo.
