# Bail if not running interactively:
[[ $- != *i* ]] && return

PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin"
export PATH

[[ $DISPLAY ]] && shopt -s checkwinsize

shopt -s histappend
shopt -s extglob
shopt -s globstar

HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoreboth

unset MAILCHECK

set -o vi


if [[ ${EUID} == 0 ]]; then
	PS1='\[\033[00;31m\]\w\[\033[0m\] '
else
	PS1='\w '
fi

PAGER=less
LESS=-iFXR
EDITOR=vi
export PAGER LESS EDITOR

case $PATH in
*$HOME/bin*)
	:
	;;
*)
	PATH=$HOME/bin:$PATH
	;;
esac

command -v vim >/dev/null && EDITOR=vim

alias ls='ls -1F'
alias c='tput clear'

if [ "$(command -v kubectl)" ] && [ -z ${_kubectl+x} ]; then
	source <(kubectl completion bash)
fi

GOPATH=$HOME/src/go
export GOPATH

if [ -d $GOPATH/bin ]; then
	PATH=$PATH:$GOPATH/bin
fi
