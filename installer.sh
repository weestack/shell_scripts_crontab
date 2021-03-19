#!/bin/sh

. ./settings.sh

start_editor="export DISPLAY=$display;export REMOTE_PATH=$remote_folder; /bin/sh $start_day_script_path;"
end_editor="export DISPLAY=$display;export REMOTE_PATH=$remote_folder;export EDITOR_NAME=$text_editor_name;/bin/sh $end_day_script_path;"

print_commands() {
    printf "=======================================================\n"
    printf "'q' - to stop the script\n"
    printf "'h' - to open this help text\n"
    printf "'first' - to run first time setup\n"
    printf "'deactivate' - to deactivate crontabs \n"
    printf "'update' - to update setting according to settings.sh \n"
    printf "=======================================================\n"
}


first_time_setup() {
    # Update
    install_dependencies
    install=$(which gedit)
    # Check install went well
    echo $install
    if [ "$install" != "" ]
    then
        echo "Dependencies successfully installed, progressing to setting up crontab";
        init_cronjob
        prepare_daily_scripts
    else
        echo "Unknown error happend"
    fi

}

init_cronjob() {
    cp crontab_template.txt crontab;
    # Append start day crontab to cronfile
    echo "$start_minute $start_hour $start_day $start_month $start_weekday $start_editor" >> crontab;
    # Append end day crontab to cronfile
    echo "$end_minute $end_hour $end_day $end_month $end_weekday $end_editor" >> crontab;
    # set crontab to new file created
    crontab crontab;
    # cleanup service
    rm crontab

    prinf "Cronjob initiated\n\n"
}


prepare_daily_scripts() {
    sudo mkdir -p $daily_scripts_folder
    sudo chown $USER $daily_scripts_folder
    cp ./$start_day_script_name $daily_scripts_folder
    cp ./$end_day_script_name $daily_scripts_folder
    printf "Daily Scripts copied to '%s'\n\n" "$daily_scripts_folder"
}


install_dependencies() {
        sudo apt update;
        sudo apt install gedit -y;
        gsettings set org.gnome.gedit.preferences.editor auto-save-interval $autosave_interval;
        gsettings set org.gnome.gedit.preferences.editor auto-save $autosave;
}

update_cronjob_with_new_settings() {
    init_cronjob
    prepare_daily_scripts
    printf "Updating daily scripts and crontab"
}

disable_conjob_and_cleanup() {
    printf "removing daily script files from '%s'\n\n" "$daily_scripts_folder"
    sudo rm -rf $daily_scripts_folder
    printf "Disabling crontabs\n"
    cp crontab_template.txt cronfile
    crontab cronfile
    printf "Done cleaning up\n\n"
}


while :;
do
    echo "Enter command, h for help and q for quit"
    read cmd
    cmd=$(echo $cmd | tr [A-Z] [a-z] )

    case $cmd in
        # Quit command
        q) echo "Exiting script"; break ;;

        # Help command
        h) print_commands ;;

        first) first_time_setup ;;
        update) update_cronjob_with_new_settings ;;
        deactivate) disable_conjob_and_cleanup ;;

        *)
        printf "Command '%s' unknown, please look for typos in your command and try again\n" "$cmd"
        ;;
    esac
done
