# Set keyboard to UK
setxkbmap gb &

# Statusbar
/bin/dwm_status &

# Dunst
/home/joe/.config/dunst/wal.sh &

# Change wallpaper
wal -i /mnt/storage/Pictures/Wallpapers

# Dunst
/home/joe/.config/dunst/wal.sh &

# Build dwm
cd /home/joe/dwm
sudo make clean install
cd /home/joe

# Start dwm
compton --config ~/.config/compton/compton.conf -b
exec dwm

