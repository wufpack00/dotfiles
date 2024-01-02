#!/bin/bash
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos
set -eufo pipefail


###############################################################################
# General UI/UX                                                               #
###############################################################################
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'



defaults write NSGlobalDomain AppleInterfaceStyle Dark

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to the desktop
mkdir -p "${HOME}/Desktop/screenshots" && defaults write com.apple.screencapture location -string "${HOME}/Desktop/screenshots"


###############################################################################
# Finder                                                                      #
###############################################################################

# Set Documents as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Documents/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true


# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library #&& xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

killall Finder
###############################################################################
# Dock                                                                        #
###############################################################################
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false
# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false
# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock orientation -string bottom
# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

killall Dock

###############################################################################
# Safari                                                                      #
###############################################################################

# Privacy: don’t send search queries to Apple
#defaults write com.apple.Safari UniversalSearchEnabled -bool false
#defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
#defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Disable AutoFill
#defaults write com.apple.Safari AutoFillFromAddressBook -bool false
#defaults write com.apple.Safari AutoFillPasswords -bool false
#defaults write com.apple.Safari AutoFillCreditCardData -bool false
#defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Enable “Do Not Track”
#defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
#defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

#killall Safari
