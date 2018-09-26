#!/bin/sh -x

F=$(dirname $0)/files

##
## Firefox
##

ff_profile_dir=~/Library/Application\ Support/Firefox/Profiles

for d in "$ff_profile_dir"/*.default "$ff_profile_dir"/*.priv; do
	if ! [ -d "$d" ]; then
		continue
	fi

	mkdir -p "$d"/chrome
	cp $F/user.uc.js "$d"/chrome/user.uc.js
	cp $F/userChrome.css "$d"/chrome/userChrome.css
done

##
## Keymap
##

# Swap ~ and §
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}]}'

##
## Apperance
##

defaults write -g NSRequiresAquaSystemAppearance -bool Yes
