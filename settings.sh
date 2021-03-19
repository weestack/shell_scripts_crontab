# Get Username
name_name=$USER

# Get homefolder
home_folder=$HOME

# RemoteFolder
remote_folder=$(echo "$HOME/Desktop/MBR/invlist/")

# Start and End day script
daily_scripts_folder="/opt/rpi_cron_scripts/"
start_day_script_name="start_day.sh"
start_day_script_path=`echo $daily_scripts_folder"$start_day_script_name"`

end_day_script_name="end_day.sh"
end_day_script_path=`echo $daily_scripts_folder"$end_day_script_name"`

# Start text editor
start_minute=0
start_hour=7
start_day=\*
start_month=\*
start_weekday=\*


# stop text editor
end_minute=0
end_hour=18
end_day=\*
end_month=\*
end_weekday=\*

# Display that raspberry py is set to
display=$DISPLAY

# Text editor
text_editor_name=gedit
text_editor_path=$(which gedit)

# Text editor settings
autosave=true
#interval in minutes
autosave_interval=5
