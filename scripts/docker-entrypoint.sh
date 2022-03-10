#! /bin/sh
echo "SETTING USER ID'S..."
usermod -u ${PUID} steam >/dev/null
groupmod -g ${PGID} steam >/dev/null
echo "DONE"

if [ -z "$APP_ID" ]; 
then
    echo "APP_ID IS UNSET, EXITING...";
    exit 1;
fi

CMD="${STEAMCMD} +force_install_dir ${INSTALL_DIR} +login anonymous +app_update ${APP_ID} validate +quit"
echo "INSTALLING WITH COMMAND $CMD"
runuser -l steam -c "$CMD"
echo "DONE"

if [ -n "$START_CMD" ];
then
    echo "STARTING SERVER WITH COMMAND $START_CMD"
    cd $INSTALL_DIR
    runuser -l steam -c "$START_CMD"
    echo "SERVER CLOSED, EXITING"
fi

exit 0
