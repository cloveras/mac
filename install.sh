#/bin/sh

if ! [ -x /usr/local/bin/brew ]; then
	hburl=https://raw.githubusercontent.com/Homebrew/install/master/install
	ruby -e "$(curl -fsSL $hburl)"
fi

tap() {
	if ! brew tap | grep -q $1; then
		brew tap $1
	fi
}

pkg() {
	brew ls --versions $1 >/dev/null || brew install "$@"
}

app() {
	if ! brew cask ls --versions $1 >/dev/null 2>/dev/null; then
		if [ "$2" ]; then
			brew cask install $2
		else
			brew cask install $1
		fi
	fi
}

mas() {
	command mas list | grep -q ^$1 || command mas install $1
}

service() {
	if ! brew services list | grep -q "$1.*started"; then
		brew services start $1
	fi
}

# Support
pkg mas

# CLI
pkg bash
pkg bash-completion
pkg git
pkg tmux
pkg the_silver_searcher

# WM
app bitbar
tap crisidev/homebrew-chunkwm
pkg chunkwm --without-completions
service chunkwm
tap koekeishiya/homebrew-formulae
pkg skhd
service skhd

# Dev
pkg azure-cli
tap caskroom/versions
app java8
pkg maven
app intellij-idea-ce
pkg git-credential-manager
app visual-studio-code
tap homebrew/cask-fonts
app font-ibm-plex

# Desktop
app firefox
mas 803453959   # Slack
mas 904280696   # Things 3
mas 568494494   # Pocket
mas 880001334   # Reeder 3
app keybase
app aerial
app latest

# Media
app iina
app plex-media-player

# Security
app oversight
app lulu
mas 1333542190  # 1Password

# Menubar
app usage
app keepingyouawake

# Office
app skype-for-business
app microsoft-office
