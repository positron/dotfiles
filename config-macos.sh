#!/usr/bin/env bash

# unofficial bash "strict mode"
set -euo pipefail
IFS=$'\n\t'

# Get sudo password
sudo -v

if [[ $(uname -a) == *Darwin*  ]] && [[ ! $(command -v brew)  ]]; then
  echo "Installing Homebrew"
  [[ $(command -v xcodebuild) ]] && sudo xcodebuild -license accept
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  exit 0
fi

echo 'Run `brew bundle` to install brew packages from the Brewfile'
# Install from Brewfile
#brew bundle -v --file=Brewfile

#sudo rm -rf /Applications/Utilities/Java\ Preferences.app
#sudo rm -rf /Applications/Utilities/Feedback\ Assistant.app

echo "Setting defaults. If you get failures, allow the terminal app 'Full Disk Access' in System Settings"

osascript -e 'tell application "System Preferences" to quit'

# Global settings

# Disable the new window animation - every new window grows
# from a small one to a big one over a few hundred millisecs
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Expand save panel by default.
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Don't show Siri in the menu bar
#defaults write com.apple.Siri StatusMenuVisible -bool false

# Show volume in the menu bar
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -int 1

# All options: AirPort Displays Ink RemoteDesktop UniversalAccess WWAN Battery DwellControl IrDA "Script Menu" User
#              iChat Bluetooth Eject PPP TextInput VPN Clock ExpressCard PPPoE TimeMachine Volume
defaults write com.apple.systemuiserver menuExtras '(
  "/System/Library/CoreServices/Menu Extras/Clock.menu",
  "/System/Library/CoreServices/Menu Extras/Battery.menu",
  "/System/Library/CoreServices/Menu Extras/AirPort.menu",
  "/System/Library/CoreServices/Menu Extras/Volume.menu"
)'

# Show battery percentage in menu bar
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.battery" -bool true
defaults write com.apple.menuextra.battery '{ ShowPercent = YES; }'

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable automatic capitalization
defaults write -g NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Enable tap to click. (Don't have to press down on the trackpad -- just tap it.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.mouse.tapBehavior -int 1

# Enable full keyboard access for all controls (nost importantly, tabbing between fields/buttons in modals)
defaults write -g AppleKeyboardUIMode -int 3

# Finder

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Don't .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv'
#defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
#defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Hide recent tags
defaults write com.apple.finder ShowRecentTags -bool false

# Rearrange toolbar
#defaults write com.apple.finder "NSToolbar Configuration Browser" '{
#  "TB Default Item Identifiers" =     (
#    "com.apple.finder.BACK",
#    NSToolbarFlexibleSpaceItem,
#    "com.apple.finder.SWCH",
#    "com.apple.finder.ARNG",
#    "com.apple.finder.ACTN",
#    "com.apple.finder.SHAR",
#    "com.apple.finder.LABL",
#    NSToolbarFlexibleSpaceItem,
#    NSToolbarFlexibleSpaceItem,
#    "com.apple.finder.SRCH"
#  );
#  "TB Display Mode" = 2;
#  "TB Icon Size Mode" = 1;
#  "TB Is Shown" = 1;
#  "TB Item Identifiers" =     (
#    NSToolbarFlexibleSpaceItem,
#    "com.apple.finder.SRCH",
#    "com.apple.finder.SHAR"
#  );
#  "TB Size Mode" = 1;
#}'

# Dock, Dashboard, and hot corners

# Hide app launcher icons from the Dock
defaults write com.apple.dock static-only -bool TRUE

# Set the icon size of Dock items to 32 pixels
defaults write com.apple.dock tilesize -int 32

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don’t group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false

# Change Touch Bar control strip actions
defaults write com.apple.controlstrip '{ MiniCustomized = (
  "com.apple.system.brightness",
  "com.apple.system.media-play-pause",
  "com.apple.system.screen-lock",
  "com.apple.system.volume",
  "com.apple.system.mute"
 ); }'

# Safari & WebKit

# Show status bar (show URL when hovering over link)
defaults write com.apple.safari ShowOverlayStatusBar -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.safari com.apple.safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
#defaults write com.apple.safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default
#defaults write com.apple.safari ShowFavoritesBar -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.safari IncludeDevelopMenu -bool true
defaults write com.apple.safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.safari com.apple.safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write -g WebKitDeveloperExtras -bool true

# Warn about fraudulent websites
defaults write com.apple.safari WarnAboutFraudulentWebsites -bool true

# Update extensions automatically
defaults write com.apple.safari InstallExtensionUpdatesAutomatically -bool true

# Activity Monitor

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Mac App Store

# Check for software updates daily
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Photos

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "Doing a soft restart of affected services. You still need to do a full restart.." 

for app in "SystemUIServer" "cfprefsd" "Finder" "Dock" "ControlStrip" "Safari" "TextEdit" "ActivityMonitor"; do
    killall $app
done
