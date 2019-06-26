# Set keyboard to UK
setxkbmap gb &

# Statusbar
dwm-bar &

# nm-applet
nm-applet &

# Change wallpaper
wal -i /home/joe/pictures/wallpapers

# Dunst
/home/joe/.config/dunst/wal.sh &

# Build st
cd /home/joe/.config/st
sudo make clean install

# Build dmenu
cd /home/joe/.config/dmenu
sudo make clean install

# Build dwm
cd /home/joe/.config/dwm
sudo make clean install
cd /home/joe

# Start dwm
compton --config ~/.config/compton/compton.conf -b
exec dwm

