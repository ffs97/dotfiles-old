#! /bin/bash

# Set natural scrolling and Velocity Scaling
$HOME/utilities/general/touchpad/natural-scrolling.sh &
$HOME/utilities/general/touchpad/tapping.sh &
$HOME/utilities/general/touchpad/disabled-while-typing.sh -v &

# Make numpad like in Microsoft
setxkbmap -option 'numpad:microsoft' &

# Sourcing Xresources
xrdb ~/.Xresources

# Run blueman
blueman-applet &

# Running Pulseaudio
volume set +0

# Run dropbox client
dropbox &

# Kill all instances of compton and polybar
killall -q compton

# Wait for 5 seconds before starting compton
sleep 5

# Run new instance of compton
while pgrep -x compton >/dev/null; do
	sleep 1;
done
compton --config=$HOME/.config/compton/config &
