#!/bin/sh

ROOT=$(cd "$(dirname "$0")"; pwd -P)
TEMPLATES=$ROOT/templates
FILES=$ROOT/files

##
## Firefox
##

ff_profile_dir=~/Library/Application\ Support/Firefox/Profiles

for d in "$ff_profile_dir"/*.default "$ff_profile_dir"/*.priv; do
	if ! [ -d "$d" ]; then
		continue
	fi

	mkdir -p "$d"/chrome
	cp $TEMPLATES/user.uc.js "$d"/chrome/user.uc.js
	cp $TEMPLATES/userChrome.css "$d"/chrome/userChrome.css
done

##
## Keymap
##

# Swap ~ and §
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}]}'

##
## Dotfiles
##

for f in $(find $FILES -type f); do
	rel=${f##$FILES/}
	src="$FILES/$rel"
	dst="$HOME/$rel"

	mkdir -p $(dirname "$dst")

	if ! [ -h "$dst" ]; then
		ln -s "$src" "$dst"
	fi
done

##
## Shell
##

if ! grep -q /usr/local/bin/bash /etc/shells; then
	echo >> /usr/local/bin/bash >> /etc/shells
fi

if [ "$SHELL" != /usr/local/bin/bash ]; then
	chsh -s /usr/local/bin/bash
fi
