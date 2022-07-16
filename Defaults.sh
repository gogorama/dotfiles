#!/usr/bin zsh

# macOS Preferences Defaults!! (MacOS Monterey 12.4)

## PREP
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
	osascript -e 'tell application "System Preferences" to quit'

## DOCK & MENU BAR
	defaults write com.apple.dock orientation bottom

	defaults write com.apple.dock tilesize -int 35

	defaults write com.apple.dock mineffect -string "scale"

	defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

	defaults write com.apple.scriptmenu.plist ScriptMenuEnabled true

	defaults write com.apple.dock show-process-indicators -bool true


## FINDER
	defaults write com.apple.finder DisableAllAnimations -bool true

	defaults write com.apple.finder ShowStatusBar -bool false

	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	defaults write com.apple.finder ShowPathbar -bool true

	defaults write com.apple.finder QLEnableTextSelection -bool true

	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" 

	defaults write com.apple.finder NewWindowTarget -string 'PfHm'

	defaults write com.apple.finder _FXSortFoldersFirst -bool true

	defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"


## GENERAL
	defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int "1" 

	defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

	defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true 

## BUILT-IN APPS
    defaults write com.apple.TextEdit RichText -int 0

    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

    defaults write com.apple.dashboard devmode -bool true


## DISPLAY
    defaults write com.apple.screencapture location -string "${HOME}/Documents/Pictures/Screenshots/"

    defaults write com.apple.screencapture type -string "png"

    defaults write NSGlobalDomain AppleFontSmoothing -int 2

    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true


## SYSTEM
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    defaults write NSGlobalDomain NSDisableAutomaticTermination -bool false

    sudo systemsetup -setrestartfreeze on

    defaults write com.apple.LaunchServices LSQuarantine -bool false 

    sudo systemsetup -setcomputersleep 60

    sudo pmset -a hibernatemode 0


## I/O
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

	defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

	defaults write NSGlobalDomain KeyRepeat -int 2

	defaults write NSGlobalDomain InitialKeyRepeat -int 15

	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

## END
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Messages" "Safari" "SystemUIServer" "Terminal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."



