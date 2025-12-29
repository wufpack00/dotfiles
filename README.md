# 👩‍💻 Dotfiles

Many thanks to all the bloggers, coders, github-ers, etc. that have provided countless examples for me to use as a starting point.

## Installation

To install [chezmoi](https://www.chezmoi.io/) as well as the defined dotfile configurations, use the following command:

```bash
# Will prompt to install developer tools if not found
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --purge-binary --apply wufpack00
```

The `--purge-binary` flag will remove the binary after the installation is done.
Chezmoi will install itself using the preferred package manager on the system.

### Troubleshooting

If an error occurs, you may need to restart the apply process at a specific spot. To do clear, you must to clear the state of run_onchange_ scripts:
```bash
chezmoi state delete-bucket --bucket=entryState
```

## Usage Patterns

`cz` alias is defined in `/home/private_dot_config/zsh/aliases.zsh`

```bash

# Update dotfiles from the source directory
cz apply

# simulate creating the config file with no existing template data
cz init --data=false

# useful for testing templates
cz execute-template < home/.chezmoiscripts/darwin/run_onchange_before_install-packages.sh.tmpl

# open file in perferred editor for modifying
cz edit

# Check for common problems.
cz doctor

# Pull the latest changes from remote repo and runs `chezmoi apply`
cz update

```

## Secrets

Stored in [1Password](https://1password.com) and [1Password CLI](https://developer.1password.com/docs/cli/) will be installed (if necessary) when `cz apply` is executed via `/home/.install-prerequisities.sh`

Login to 1Password with:

```console
$ eval $(op signin)
```

## Package Management

Packages are managed with:

- [Homebrew](https://brew.sh/) for MacOS in `/home/.chezmoiscripts/darwin/run_onchange_before_install-packages.sh.tmpl`
