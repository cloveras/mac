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

pkg mas

pkg bash
pkg bash-completion
pkg git
pkg tmux
pkg pass

app bitbar
tap crisidev/homebrew-chunkwm
pkg chunkwm --without-completions
service chunkwm
tap koekeishiya/homebrew-formulae
pkg skhd
service skhd

pkg azure-cli
app java
pkg maven
pkg git-credential-manager

app firefox
app keybase
app aerial
app latest
app iina
app plex-media-player
app oversight
app usage
app visual-studio-code
tap homebrew/cask-fonts
app font-ibm-plex
app skype-for-business
app microsoft-office

mas 803453959   # Slack
mas 1333542190  # 1Password
mas 904280696   # Things 3
mas 568494494   # Pocket
mas 880001334   # Reeder 3
