# Set keyboard to UK
setxkbmap gb &

# Statusbar
dwm-bar &

# nm-applet
nm-applet &

# Change wallpaper
wal -i /usr/share/void-artwork/void-logo.png

# Dunst
/home/$USER/.config/dunst/wal.sh &

# Build st
cd /home/$USER/.config/st
sudo make clean install

# Build dmenu
cd /home/$USER/.config/dmenu
sudo make clean install

# Build dwm
cd /home/$USER/.config/dwm
sudo make clean install
cd /home/$USER

# Start dwm
compton --config ~/.config/compton/compton.conf -b
exec dwm

