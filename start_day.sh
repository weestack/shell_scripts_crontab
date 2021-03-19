#!/bin/sh

file=$(echo "incominginv$REMOTE_PATH.txt")
echo $file > /home/weestack/test.txt
touch $file
gedit --new-window -s $file
