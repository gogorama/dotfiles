#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'
echo "Preparing to run..."

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# General System                                                              #
echo "1/7; Processing General System Settings"                                
###############################################################################

	# Set computer name (as done via System Preferences → Sharing)
	sudo scutil --set ComputerName "joesmacpro"
	sudo scutil --set HostName "joesmacpro"
	sudo scutil --set LocalHostName "joesmacpro"
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "joesmacpro"

	# Set highlight color to green
	defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

	# Set sidebar icon size to small('1'), medium('2'), or large('3')
	defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

	# Show scrollbars (`WhenScrolling`, `Automatic` or `Always')
	defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

	# Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

	# Disable the “Are you sure you want to open this application?” dialog
	defaults write com.apple.LaunchServices LSQuarantine -bool false

	# Reveal IP address, hostname, OS version, etc. when clicking the clockin the login window
	sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

	# Disables auto capitalization
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true 

	# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

	# Use scroll gesture with the Ctrl (^) modifier key to zoom
	defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
	defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

	# Require password immediately after sleep or screen saver begins
	defaults write com.apple.screensaver askForPassword -int 1
	defaults write com.apple.screensaver askForPasswordDelay -int 0

	# Save screenshots to the configured folder
	defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

	# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
	defaults write com.apple.screencapture type -string "png"

	# Disable shadow in screenshots
	defaults write com.apple.screencapture disable-shadow -bool true

	# Enable subpixel font rendering on non-Apple LCDs
	# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
	defaults write NSGlobalDomain AppleFontSmoothing -int 1

	# Enable HiDPI display modes (requires restart)
	sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true 

	# Finder: disable window animations and Get Info animations
	defaults write com.apple.finder DisableAllAnimations -bool true

	# Show icons for hard drives, servers, and removable media on the desktop
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

	# Finder: show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Finder: show path bar
	defaults write com.apple.finder ShowPathbar -bool true

	# Keep folders on top when sorting by name
	defaults write com.apple.finder _FXSortFoldersFirst -bool true

	# When performing a search, search the current folder by default
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

	# Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true

	# Enable spring loading for directories
	defaults write NSGlobalDomain com.apple.springing.enabled -bool true

	# Remove the spring loading delay for directories
	defaults write NSGlobalDomain com.apple.springing.delay -float 0

	# Avoid creating .DS_Store files on network or USB volumes
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	# Disable disk image verification
	defaults write com.apple.frameworks.diskimages skip-verify -bool true
	defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
	defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

	# Automatically open a new Finder window when a volume is mounted
	defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
	defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
	defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

	# Enable snap-to-grid for icons on the desktop and in other icon views
	/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
	/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
	/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

	# Use list view in all Finder windows by default
	# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

	# Enable AirDrop over Ethernet and on unsupported Macs running Lion
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

	# Show the ~/Library folder
	chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

	# Show the /Volumes folder
	sudo chflags nohidden /Volumes

	# Expand the following File Info panes:
	# “General”, “Open with”, and “Sharing & Permissions”
	defaults write com.apple.finder FXInfoPanesExpanded -dict \
		General -bool true \
		OpenWith -bool true \
		Privileges -bool true

	# Enable highlight hover effect for the grid view of a stack (Dock)
	defaults write com.apple.dock mouse-over-hilite-stack -bool true

	# Set the icon size of Dock items to 24 pixels
	defaults write com.apple.dock tilesize -int 24

	# Change minimize/maximize window effect
	defaults write com.apple.dock mineffect -string "scale"

	# Minimize windows into their application’s icon
	defaults write com.apple.dock minimize-to-application -bool true

	# Enable spring loading for all Dock items
	defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

	# Show indicator lights for open applications in the Dock
	defaults write com.apple.dock show-process-indicators -bool true

	# Don’t animate opening applications from the Dock
	defaults write com.apple.dock launchanim -bool false

	# Speed up Mission Control animations
	defaults write com.apple.dock expose-animation-duration -float 0.1

	# Don’t group windows by application in Mission Control
	# (i.e. use the old Exposé behavior instead)
	defaults write com.apple.dock expose-group-by-app -bool false

	# Don’t automatically rearrange Spaces based on most recent use
	defaults write com.apple.dock mru-spaces -bool false

	# Remove the auto-hiding Dock delay
	defaults write com.apple.dock autohide-delay -float 0
	# Remove the animation when hiding/showing the Dock
	defaults write com.apple.dock autohide-time-modifier -float 0

	# Automatically hide and show the Dock
	defaults write com.apple.dock autohide -bool false

	# Make Dock icons of hidden applications translucent
	defaults write com.apple.dock showhidden -bool true

	# Don’t show recent applications in Dock
	defaults write com.apple.dock show-recents -bool false

	# Only use UTF-8 in Terminal.app
	defaults write com.apple.terminal StringEncodings -array 4

	# Enable “focus follows mouse” for Terminal.app and all X11 apps i.e. hover over a window and start typing in it without clicking first
	defaults write com.apple.terminal FocusFollowsMouse -bool true
	defaults write org.x.X11 wm_ffm -bool true

	# Enable Secure Keyboard Entry in Terminal.app
	defaults write com.apple.terminal SecureKeyboardEntry -bool true

	# Disable the annoying line marks
	defaults write com.apple.Terminal ShowLineMarks -int 0

	# Show the main window when launching Activity Monitor
	defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

	# Visualize CPU usage in the Activity Monitor Dock icon
	defaults write com.apple.ActivityMonitor IconType -int 5

	# Show all processes in Activity Monitor
	defaults write com.apple.ActivityMonitor ShowCategory -int 0

	# Sort Activity Monitor results by CPU usage
	defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
	defaults write com.apple.ActivityMonitor SortDirection -int 0

	# Enable Dashboard dev mode (allows keeping widgets on the desktop)
	defaults write com.apple.dashboard devmode -bool true

	# Enable the debug menu in iCal (pre-10.8)
	defaults write com.apple.iCal IncludeDebugMenu -bool true

	# Use plain text mode for new TextEdit documents
	defaults write com.apple.TextEdit RichText -int 0

	# Open and save files as UTF-8 in TextEdit
	defaults write com.apple.TextEdit PlainTextEncoding -int 4
	defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

	# Enable the debug menu in Disk Utility
	defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
	defaults write com.apple.DiskUtility advanced-image-options -bool true

	# Auto-play videos when opened with QuickTime Player
	defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

	# Disable automatic emoji substitution (i.e. use plain text smileys)
	defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool true


###############################################################################
# Kill affected applications                                                  #
echo "All Finished! Refreshing System"
###############################################################################

	for app in "Activity Monitor" \
		"Address Book" \
		"Calendar" \
		"cfprefsd" \
		"Contacts" \
		"Dock" \
		"Finder" \
		"Mail" \
		"Messages" \
		"Safari" \
		"SystemUIServer" \
		"Terminal" \
		"iCal"; do
		killall "${app}" &> /dev/null
	done
	echo "Done. Note that some of these changes require a logout/restart to take effect."
