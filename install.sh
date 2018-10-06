#/bin/sh

if ! [ -x /usr/local/bin/brew ]; then
	hburl=https://raw.githubusercontent.com/Homebrew/install/master/install
	ruby -e "$(curl -fsSL $hburl)"
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

app google-photos-backup-and-sync
app keybase
app cursorcerer
app visual-studio-code

mas 803453959   # Slack
mas 1333542190  # 1Password
mas 904280696   # Things 3
mas 568494494   # Pocket
mas 880001334   # Reeder 3

if ! [ -x $HOME/.cargo/bin/rustup ]; then
	curl https://sh.rustup.rs -sSf | sh
fi

if ! [ -d $HOME/src/alacritty/.git ]; then
	mkdir -p $HOME/src
	(
		cd $HOME/src
		git clone https://github.com/jwilm/alacritty
	)
fi

(
	ALACRITTY_V=0.2.1
	cd $HOME/src/alacritty
	git fetch
	git checkout tags/v$ALACRITTY_V

	if ! [ -e /Applications/Alacritty.app ]; then
		make app
		cp -r target/release/osx/Alacritty.app /Applications/
	fi
)
