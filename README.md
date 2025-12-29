# 👩‍💻 Dotfiles

Many thanks to all the bloggers, coders, github-ers, etc. that have provided countless examples for me to use as a starting point.

## Installation

To install [chezmoi](https://www.chezmoi.io/) as well as the defined configurations, use the following command:

```bash
# Will prompt to install developer tools if not found
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --purge-binary --apply wufpack00
```

The `--purge-binary` flag will remove the binary after the installation is done.
Chezmoi will install itself using the preferred package manager on the system.

Personal secrets are stored in [1Password](https://1password.com) and you'll
need the [1Password CLI](https://developer.1password.com/docs/cli/) installed.
Login to 1Password with:

```console
$ eval $(op signin)
```

## Troubleshooting

To pick up at right spot, had to clear the state of run_onchange_ scripts:
```bash
chezmoi state delete-bucket --bucket=entryState
```
