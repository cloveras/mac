#!/bin/sh

pkg() {
	brew ls --versions $1 >/dev/null || brew install $1
}

pkg pass
