#!/bin/sh

file="$REMOTE_PATH/incominginv$(date +"%Y%m%d").txt"
echo $file > /home/weestack/test.txt
touch $file
gedit --new-window -s $file
