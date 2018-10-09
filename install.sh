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
	brew cask ls --versions $1 >/dev/null 2>/dev/null || brew cask install $1
}

mas() {
	command mas list | grep -q ^$1 || command mas install $1
}

pkg mas

pkg tmux
pkg pass
pkg azure-cli

app contexts
app iterm2
app keybase
app cursorcerer
app visual-studio-code
app font-ibm-plex
app skype-for-business
app microsoft-office

mas 803453959   # Slack
mas 1333542190  # 1Password
mas 904280696   # Things 3
mas 568494494   # Pocket
mas 880001334   # Reeder 3
