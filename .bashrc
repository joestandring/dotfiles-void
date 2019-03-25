# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Import colourshcemes from 'wal' asynchronosly
(cat ~/.cache/wal/sequences &)

# TTY colourscheme
source ~/.cache/wal/colors-tty.sh

# Drop into fish
exec fish
