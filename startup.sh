#!/bin/bash
setxkbmap -option ctrl:nocaps
xinput set-prop 13 "libinput Accel Speed" -0.8
sudo powertop --auto-tune
