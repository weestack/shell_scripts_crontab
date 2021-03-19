#!/bin/sh

file="$REMOTE_PATH/incominginv$(date +"%Y%m%d").txt"
touch $file

gsettings set org.gnome.gedit.preferences.editor auto-save-interval 1;
gsettings set org.gnome.gedit.preferences.editor auto-save true;

gedit --new-window -s $file
