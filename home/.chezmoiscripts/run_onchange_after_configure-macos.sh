#!/bin/bash

set -eufo pipefail

# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

defaults write NSGlobalDomain AppleInterfaceStyle Dark

defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock launchanim -bool true
defaults write com.apple.dock orientation bottom
defaults write com.apple.dock show-recents -bool false
