#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Added by ASZ on 2023.10.02.1

DISPLAY=:0

figlet -c "Welcome back, $USER"
neofetch

/home/pilot/.local/bin/dropbox.py start >/dev/null 2> /dev/null &

