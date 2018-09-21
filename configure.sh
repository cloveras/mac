#!/bin/sh -x

F=$(dirname $0)/files

ff_profile_dir=~/Library/Application\ Support/Firefox/Profiles

for d in "$ff_profile_dir"/*.default "$ff_profile_dir"/*.priv; do
	if ! [ -d "$d" ]; then
		continue
	fi

	mkdir -p "$d"/chrome
	cp $F/user.uc.js "$d"/chrome/user.uc.js
	cp $F/userChrome.css "$d"/chrome/userChrome.css
done
