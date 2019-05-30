#!/bin/sh
# Screenshot: http://s.natalian.org/2013-08-17/dwm_status.png
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
function get_bytes {
# Find active network interface
interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
eval $line
now=$(date +%s%N)
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.

function get_velocity {
value=$1
old_value=$2
now=$3

timediff=$(($now - $old_time))
velKB=$(echo "1000000000*($value-$old_value)/1024/$timediff" | bc)
if test "$velKB" -gt 1024
then
	echo $(echo "scale=2; $velKB/1024" | bc)MB/s
else
	echo ${velKB}KB/s
fi
}

# Get initial values
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

# Prints alsa volume
print_volume() {
	volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	if test "$volume" -gt 0
	then
		echo -e "[VOL ${volume}]"
	else
		echo -e "[VOL Mute]"
	fi
}

# Prints connected wifi network
print_wifi() {
	ip=$(ip route get 8.8.8.8 2>/dev/null|grep -Eo 'src [0-9.]+'|grep -Eo '[0-9.]+')

	if hash iw
	then
		wifi=$(iw wlp2s0 link | grep SSID | sed 's,.*SSID: ,,')
		connectedto=$(iw wlp2s0 link | grep Connected | awk '{print $3}' | cut -c 10-)
	fi

	echo -e "[NET $wifi $ip]"
}

# Prints memory usage
print_mem(){
	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	echo -e "$memfree"
}

# Prints system temperature
print_temp(){
	test -f /sys/class/thermal/thermal_zone0/temp || return 0
	echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}

#print_bat(){
#	hash acpi || return 0
#	onl="$(grep "on-line" <(acpi -V))"
#	charge="$(cat /sys/class/power_supply/BAT1/capacity)"
#	if [[ ( -z $onl && ${charge} -gt 20 ) ]]; then
#		echo -e "[BAT ${charge}]"
#	elif [[ ( -z $onl && ${charge} -le 20 ) ]]; then
#		echo -e "[BAT ${charge}]"
#	else
#		echo -e "[BAT ${charge}]"
#	fi
#}

# Prints the date and time
print_date(){
	echo [$(date "+%a %d-%m-%y %T")]
}

sec_to_ms () {
    N=$1
    M=0
    if (($N>59)); then
        ((S=$N%60))
        ((N=$N/60))
        ((M=$N))
    else
        ((S=$N))
    fi
    printf "$M:"
    printf "%02d" "$S"
}

# Prints CMUS artitst, title, and position/duration to bar
print_music(){
    if ps -C cmus > /dev/null; then
        artist=`cmus-remote -Q | 
	        grep --text '^tag artist' | 
	        sed '/^tag artistsort/d' | 
	        awk '{gsub("tag artist ", "");print}'`
        title=`cmus-remote -Q  | 
	        grep --text '^tag title' | 
	        sed -e 's/tag title //' |
	        awk '{gsub("tag title ", "");print}'`
        position=`cmus-remote -Q |
            grep --text '^position' |
            sed -e 's/position //' |
            awk '{gsub("position ", "");print}'`
        duration=`cmus-remote -Q |
            grep --text '^duration' |
            sed -e 's/duration //' |
            awk '{gsub("duration ", "");print}'`
        position=$(sec_to_ms "$position")
        duration=$(sec_to_ms "$duration")
        echo "[$artist - $title $position/$duration]"; else echo "";
    fi
}

# Prints number of emails in mutt inbox
print_mail(){
    mailcount=$(ls /home/joe/.local/share/mail/uni/INBOX/new | wc -l)
    echo "[MAIL $mailcount]"
}

print_countdown() {
    if [ -e /tmp/countdown.* ]; then
        echo "["$(tail -1 /tmp/countdown.*)"]"
    fi
}

print_weather() {
    printf "["
    curl -s wttr.in/peterborough?format=1 
    printf "]\n"
}

while true
do

	# Get new transmitted, received byte number values and current time
	get_bytes

	# Calculates speeds
	vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
	vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

    xsetroot -name "$(print_countdown)$(print_music)$(print_mail)$(print_volume)$(print_date)"

	# Update old values to perform new calculations
	old_received_bytes=$received_bytes
	old_transmitted_bytes=$transmitted_bytes
	old_time=$now

	sleep 1

done
