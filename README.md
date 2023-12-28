# 👩‍💻 Dotfiles

Many thanks to all the bloggers, coders, github-ers, etc. that have provided countless examples for me to use as a starting point.

## Installation

To install [chezmoi](https://www.chezmoi.io/) as well as the defined configurations, following command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --purge-binary --apply wufpack00
```

The `--purge-binary` flag will remove the binary after the installation is done.
Chezmoi will install itself using the preferred package manager on the system.
