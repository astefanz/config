#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Added by ASZ
alias vim=nvim
export PATH="/home/pilot/.local/bin/:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

# Keyboard
remaps # Custom key mappings and touchpad 

# Notes
export SBDIR=~/Dropbox/Notes/soundbites/
export SBFILENAME=soundbites.txt
export SBPATH=$SBDIR/$SBFILENAME
export NBDIR=/home/pilot/Dropbox/Notes/
export NBFILENAME=nb.md
export NBPATH=$NBDIR/$NBFILENAME
export EDITOR=/usr/bin/nvim

# More notes
alias jn='jupyter notebook'

