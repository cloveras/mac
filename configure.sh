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
## Dotfiles
##

find $FILES -type f -print0 | while IFS= read -r -d '' f; do
	rel=${f##$FILES/}
	src="$FILES/$rel"
	dst="$HOME/$rel"

	mkdir -p "$(dirname "$dst")"

	if ! [ -L "$dst" ]; then
		ln -sf "$src" "$dst"
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

##
## VS Code VIM
##

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
