#!/bin/sh

pkg() {
	brew ls --versions $1 >/dev/null || brew install $1
}

app() {
	brew cask ls --versions $1 >/dev/null 2>/dev/null || brew cask install $1
}

pkg tmux
pkg pass

app firefox
