# Chezmoi Dotfiles Project

## Working with Chezmoi

Claude must look up chezmoi documentation (via context7 or similar) before suggesting chezmoi-specific solutions.
Do not guess based on general knowledge — chezmoi has specific mechanisms that are easy to misapply.

## Project Overview

A chezmoi-managed dotfiles repository supporting macOS (primary) and Linux (secondary).
Secrets are stored in 1Password and accessed via `op` CLI — never hardcode credentials.

## Repository Structure

- `.chezmoiroot` sets `home/` as the chezmoi source directory
- `home/` maps to `$HOME` on target machines
- `.assets/` contains reference configs (iTerm2 plist, VS Code settings) — ignored by chezmoi
- `.chezmoiexternal.toml.tmpl` pulls oh-my-zsh, plugins, fonts, and Alfred workflows from GitHub

## Chezmoi Naming Conventions

| Prefix/Suffix | Meaning |
|---|---|
| `dot_` | File starts with `.` on target |
| `private_dot_` | Private (0700/0600) dotfile |
| `symlink_` | Symlink on target |
| `.tmpl` | Go template — rendered before placement |
| `run_onchange_before_` | Script runs before apply, re-runs when content hash changes |
| `run_onchange_after_` | Script runs after apply, re-runs when content hash changes |
| `run_after_update_` | Script runs after every `chezmoi update` |

## Script Execution Order

Scripts in `.chezmoiscripts/` run in alphabetical order within their category.
Numbering prefix (01_, 02_, 03_) controls ordering within a phase:

1. `run_onchange_before_` — install packages (Homebrew)
2. Files are applied
3. `run_onchange_after_` — install CC plugins, configure Python, Dock, defaults
4. `run_after_update_` — uninstall/upgrade packages, CC plugin maintenance

## Template Data Variables

Defined in `.chezmoi.toml.tmpl` — key variables available in templates:

- `.personal` / `.work` / `.ephemeral` / `.headless` — machine type booleans
- `.osid` — combined OS identifier (e.g., `darwin`, `linux-fedora`)
- `.install.containers` / `.install.golang` / `.install.iac` / `.install.python` — tool toggles
- `.preferences.chatApps` / `.collabApps` / `.meetApps` / `.manageDock` — app preferences

## Testing Templates

```bash
# Render a template to stdout
chezmoi execute-template --file home/path/to/file.tmpl

# Test .chezmoi.toml.tmpl with simulated prompts
chezmoi execute-template --init --promptString email=test@example.com < home/.chezmoi.toml.tmpl

# Preview what chezmoi would change
chezmoi diff
```

## Pre-commit Hooks

The following checks run on every commit via `.pre-commit-config.yaml`:

- **shellcheck** / **shfmt** — shell script linting and formatting
- **markdownlint** / **yamllint** — markdown and YAML linting
- **gitleaks** — secret detection
- **editorconfig-checker** — consistent formatting
- Standard checks: large files, merge conflicts, trailing whitespace, private keys

## Adding Packages

Homebrew packages are managed in `home/.chezmoiscripts/darwin/run_onchange_before_install-packages.sh.tmpl`.
Add entries to the appropriate list variable:

- `$taps` — Homebrew taps
- `$brews` — CLI formulae
- `$casks` — GUI applications
- `$mas_apps` — Mac App Store apps (requires app name + numeric ID)

Conditional packages go inside the relevant `{{ if }}` block (`.personal`, `.work`, `.install.containers`, etc.).

## Claude Code Plugins

Managed in `home/.chezmoiscripts/darwin/run_onchange_after_01_install-cc-plugins.sh.tmpl`.
Uninstalls/updates in `run_after_update_03_uninstall-update-cc-plugins.sh.tmpl`.
