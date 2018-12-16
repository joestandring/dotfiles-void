# Wifi app
nm-applet &

# Set keyboard to UK
setxkbmap gb &

# Statusbar
~/scripts/dwm_status &

# Change wallpaper
wal -i /home/joe/pictures/wallpapers &

# Start dwm and Compton
compton &
exec dwm

