#!/bin/sh

# Executed via hooks.read-source-state.pre
# Runs after chezmoi init on a new machine but before chezmoi init --apply
# or chezmoi apply executes run_before_ scripts.
#  https://www.chezmoi.io/user-guide/advanced/install-your-password-manager-on-init/
set -e

is_macos() {
  [ "$(uname -s)" = "Darwin" ]
}

has_xcode_clt() {
  xcode-select -p 1>/dev/null
}

has_1password() {
  type op >/dev/null 2>&1
}

has_homebrew() {
  type brew >/dev/null 2>&1
}

# Exit immediately if we are not on macOS
is_macos || exit

# exit immediately if xcode, op and brew are already in $PATH
has_xcode_clt && has_homebrew && has_1password && exit

if ! has_xcode_clt; then
  xcode-select --install
fi

if ! has_homebrew; then
  if [ "$(/usr/bin/uname -m)" = "arm64" ]; then
    HOMEBREW_PREFIX="/opt/homebrew"
    HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
  else
    HOMEBREW_PREFIX="/usr/local"
    HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
  fi


  # only install homebrew if repository directory does not exist
  if [ ! -d "$HOMEBREW_REPOSITORY" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # If brew is not in the path yet then eval the shellenv for the rest of this pre script
  # This will not affect any other chezmoi scripts
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv bash)"
  # The only bin installed from homebrew that chezmoi needs is 1Password so if its not in the
  # path yet, we will need to symlink it later.
  NEEDS_OP_SYMLINK="1"
fi

if ! has_1password; then
  brew install --cask --adopt 1password 1password-cli
  echo "Signing in to 1Password..."
  # op account add --address my.1password.com --email xxx@email.com --signin
  echo "Opening 1Password. Please log into your account and enable CLI integration."
  open "/Applications/1Password.app"
  echo "Press Enter to continue."
  read
fi

# symlink the brew installed op to /usr/local/bin so chezmoi can find it by default
if [ -n "$NEEDS_OP_SYMLINK" ]; then
  sudo mkdir -p /usr/local/bin
  OP="/usr/local/bin/op"
  if [ ! -f "$OP" ]; then
    sudo ln -s "$HOMEBREW_PREFIX/bin/op" "$OP"
  fi
fi
