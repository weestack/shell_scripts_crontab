#!/bin/sh

file="$REMOTE_PATH/incominginv$(date +"%Y%m%d").txt"
touch $file

gsettings set org.gnome.gedit.preferences.editor auto-save-interval $AUTO_INT;
gsettings set org.gnome.gedit.preferences.editor auto-save $AUTO;

gedit --new-window -s $file >> /tmp/gedit_logging  2>&1 
