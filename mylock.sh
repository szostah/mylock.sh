#!/bin/bash

###Requirements
# - i3lock-color - https://github.com/PandorasFox/i3lock-color
# - scrot - https://github.com/dreamer/scrot
# - twmn - https://github.com/sboli/twmn (you can change it to other)
# - xautolock - https://github.com/l0b0/xautolock
# - imagemagick - https://github.com/ImageMagick/ImageMagick

###Autolock settings
TIME_TO_LOCK=9 #in minutes
TIME_BEFORE_LOCK=15 #in seconds
NOTIFIER="twmnc --aot -t MyLock -c 'Locking screen in ${TIME_BEFORE_LOCK}s' -d $[$TIME_BEFORE_LOCK*1000] --bg cyan --fg black"

###Lock screen settings
#Clock widget
SCREEN_HEIGHT=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $4}')
X_POS=100 #central ring position, starts at the bottom-left corner
Y_POS=100
WIDTH=285 #semi-transparent box size
HEIGHT=100
CLOCK_OFFSET=135 #distance between indicator center position and clock center position
PADDING=25

#Ring color
NORMAL_COLOR=42717bff
HL_COLOR=7dc1cfff
BSHL_COLOR=e1aa5dff
WRONG_COLOR=e84f4fff
VER_COLOR=8542ffbf

#Text color
TIME_COLOR=ffffffff
DATE_COLOR=ddddddff

#Help
if [ "$1" == "-h" ]; then
	echo "Usage: $0 [OPTIONS]"
	echo -e "\tOptions:"
	echo -e "\t-a \t enabling autolocking"
	echo -e "\t-s \t lock and suspend"
	echo -e "\t-h \t lock and hibernate"
	exit 1
fi

#Enabling autolocking
if [ "$1" == "-a" ]; then
	xautolock -notify $TIME_BEFORE_LOCK -notifier "$NOTIFIER" -corners 0-00 -time $TIME_TO_LOCK -locker "$0" &
	exit 1
fi

#Locking screen
x1=$[($X_POS+$CLOCK_OFFSET/2)-$WIDTH/2+$PADDING]
y1=$[$Y_POS-$HEIGHT/2]
x2=$[($X_POS+$CLOCK_OFFSET/2)+$WIDTH/2+$PADDING]
y2=$[$Y_POS+$HEIGHT/2]
scrot -z /tmp/screen.jpg
convert -scale 10% -blur 0x0.5 -resize 1000% /tmp/screen.jpg -fill "#00000f77" -stroke none -draw "rectangle $x1,$[$SCREEN_HEIGHT-$y1] $x2,$[$SCREEN_HEIGHT-$y2]" /tmp/blurred_screen.png
i3lock -i /tmp/blurred_screen.png -k --indicator --ringcolor=$NORMAL_COLOR --keyhlcolor=$HL_COLOR --ringvercolor=$VER_COLOR --ringwrongcolor=$WRONG_COLOR --bshlcolor=$BSHL_COLOR --insidevercolor=ffffff00   --insidewrongcolor=ffffff00 --insidecolor=ffffff00  --radius=30 --veriftext="" --noinputtext="" --wrongtext="" --timesize=46 --datesize=21 --time-font="Fira Sans" --date-font="Fira Sans" --verif-font="Fira Sans" --wrong-font="Fira Sans" --indpos="x+$X_POS:y+h-$Y_POS" --timepos="ix+$CLOCK_OFFSET:iy" --line-uses-inside --separatorcolor=00000000 --ring-width=10 --timecolor=$TIME_COLOR --datecolor=$DATE_COLOR --datestr="%a, %Y-%m-%d"

#Additional options
if [ "$1" == "-s" ]; then
	systemctl suspend
elif [ "$1" == "-h" ]; then
	systemctl hibernate
fi
