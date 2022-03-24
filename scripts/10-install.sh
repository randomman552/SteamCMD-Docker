#! /bin/sh
# Script installs the server if APP_ID is set
if [ -z "$APP_ID" ]; 
then
    echo "APP_ID is unset, skipping...";
    exit 1;
fi

/home/steam/steamcmd.sh +force_install_dir "/server/" +login anonymous +app_update ${APP_ID} validate +quit;

exit 0;
