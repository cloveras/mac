#/bin/sh

if ! [ -x /usr/local/bin/brew ]; then
	hburl=https://raw.githubusercontent.com/Homebrew/install/master/install
	ruby -e "$(curl -fsSL $hburl)"
fi

if ! brew tap | grep -q homebrew/cask-fonts; then
	brew tap homebrew/cask-fonts
fi

pkg() {
	brew ls --versions $1 >/dev/null || brew install $1
}

app() {
	if ! brew cask ls --versions $1 >/dev/null 2>/dev/null; then
		if [ "$2"]; then
			brew cask install $2
		else
			brew cask install $1
		fi
	fi
}

mas() {
	command mas list | grep -q ^$1 || command mas install $1
}

pkg mas

pkg tmux
pkg pass
pkg azure-cli

app amethyst
app firefox
app keybase
app cursorcerer
app iina
app oversight
app usage
app dozer https://raw.githubusercontent.com/Mortennn/Dozer/master/dozer.rb
app visual-studio-code
app font-ibm-plex
app skype-for-business
app microsoft-office

mas 803453959   # Slack
mas 1333542190  # 1Password
mas 904280696   # Things 3
mas 568494494   # Pocket
mas 880001334   # Reeder 3
