# *2023.10.02.1 by ASZ
#

# Set desired fonts and resolution
# See: https://wiki.archlinux.org/title/Font_configuration
xset +fp /usr/share/fonts/ttf-linux-libertine/
xrandr --dpi 120

# Apply custom keybindings
remaps

# Set up text for dwm top bar
while true; do
xsetroot -name "$(rem)   *nvim ter: <Ctrl-\><Ctrl-N>    $(date +%Y.%m.%d\ ~%H%M\ @%Z)    BAT: $(cat /sys/class/power_supply/CMB1/capacity)%"
	sleep 1m
done &

# Set desktop background
setbg &

# Start conky
conky --daemonize --pause=1 --config=$HOME/.config/conky/conky.conf &
conky --daemonize --pause=1 --config=$HOME/.config/conky/conky_alt.conf &

# Launch dwm
while true; do
	exec dwm 2> /dev/null
done
