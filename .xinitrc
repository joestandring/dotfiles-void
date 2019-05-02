# Set keyboard to UK
setxkbmap gb &

# Statusbar
/home/joe/scripts/dwm_status.sh &

# nm-applet
nm-applet &

# Change wallpaper
wal -i /mnt/storage/Pictures/Wallpapers

# Dunst
/home/joe/.config/dunst/wal.sh &

# Get mail
mbsync uni &

# Build dwm
cd /home/joe/.config/dwm
sudo make clean install
cd /home/joe

# Start dwm
compton --config ~/.config/compton/compton.conf -b
exec dwm

