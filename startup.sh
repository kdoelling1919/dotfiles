#!/bin/bash

# The purpose of this file is to open the applications we always do and
# organize them a bit so we can get off the ground running 
#
# It requires the installation of wmctrl

sleep 6
# Load our inital start up apps
wmctrl -s 0
gnome-terminal &
thunderbird &
slack &
firefox www.gmail.com &

count=$(wmctrl -l | grep -ic -e slack -e thunderbird -e firefox)
check=3
# Wait until all 3 applications have loaded
while [ "$count" != "$check" ]
do 
  sleep 0.5
  count=$(wmctrl -l | grep -ic -e slack -e thunderbird -e firefox)
done

# Move windows to their respective workspaces
wmctrl -r thunderbird -t 1
while (( $(wmctrl -d | wc -l) <= 2 ))
do
  sleep 0.5
done
wmctrl -r slack -t 2
while (( $(wmctrl -d | wc -l) <= 3 ))
do
  sleep 0.5
done
wmctrl -r firefox -t 3
while (( $(wmctrl -d | wc -l) <= 4 ))
do
  sleep 0.5
done
wmctrl -s 0
