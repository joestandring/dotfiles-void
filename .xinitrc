# Set keyboard to UK
setxkbmap gb &

# Scripts
/home/joe/scripts/dwm_status &
/home/joe/scripts/bat_notif &

# Applets
nm-applet &
blueman-applt &

# Change wallpaper
wal -i /home/joe/pictures/wallpapers/

# Dunst
/home/joe/.config/dunst/wal.sh &

# Build dwm
cd /home/joe/.config/dwm
sudo make clean install
cd /home/joe

# Start dwm
# compton --config ~/.config/compton/compton.conf -b
exec dwm

