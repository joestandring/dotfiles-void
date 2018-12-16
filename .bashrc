# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Import colourschemes from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)

# TTY colourscheme
source ~/.cache/wal/colors-tty.sh

neofetch
