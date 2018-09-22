#!/bin/sh

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

app firefox

mas 803453959  # Slack
