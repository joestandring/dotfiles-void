# Change wallpaper
wal -i /home/joe/wallpapers

# Set keyboard to UK
setxkbmap gb &

# Statusbar
/bin/dwm_status &

# Dunst
/home/joe/.config/dunst/wal.sh &

# Start dwm
# compton --backend xrender &
exec dwm

