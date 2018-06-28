# mylock.sh
My lockscreen script based on i3lock-color with blurred background. It's a part of my i3 tile wm config.

## Requirements
- i3lock-color [github](https://github.com/PandorasFox/i3lock-color)
- scrot [github](https://github.com/dreamer/scrot)
- xautolock [github](https://github.com/l0b0/xautolock)
- imagemagick [github](https://github.com/ImageMagick/ImageMagick)
- twmn [github](https://github.com/sboli/twmn)

## Features
- screen locks automatically (xautolock),
- background of lockscreen is a blurred screenshot (scrot, imagemagick),
- the clock is on a semi-transparent dark rectangular shape, which increases readability on light background (imagemagick),
- while the mouse cursor is on the top-right corner, xautolock should not start the locker (```-corners``` option),
- xautolock notify us before locking.

## Screenshots
![screen1](https://user-images.githubusercontent.com/10513420/42002608-3ba7df48-7a68-11e8-92a4-b79fe3f3baa3.png)
![screen2](https://user-images.githubusercontent.com/10513420/42002823-eea60cc8-7a68-11e8-8fa3-d0998d3ebad8.png)
![screen3](https://user-images.githubusercontent.com/10513420/42002910-4af3215a-7a69-11e8-8c6d-55da673625ce.png)

## Usage
```
Usage: mylock.sh [OPTIONS]
	Options:
	-a 	 enabling autolocking
	-s 	 lock and suspend
	-h 	 lock and hibernate
```

## i3 integration
![i3](https://user-images.githubusercontent.com/10513420/42003218-a1bd5c02-7a6a-11e8-85cd-545a63a3e916.png)
```
exec --no-startup-id mylock -a 

set $system_mode System:     L :  | S :  | H :   | P :  | R : 
mode "$system_mode" {
	bindsym l exec --no-startup-id mylock, mode "default"
	bindsym s exec --no-startup-id mylock -s, mode "default"
	bindsym h exec --no-startup-id mylock -h, mode "default"
	bindsym p exec --no-startup-id systemctl poweroff -i, mode "default"
	bindsym r exec --no-startup-id systemctl reboot, mode "default"
        bindsym Return mode "default"
        bindsym Escape mode "default"
}
bindsym $mod+x mode "$system_mode"
```
