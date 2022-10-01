#! /bin/sh
# Script installs the server if APP_ID is set
if [ -z "$APP_ID" ]; 
then
    echo "APP_ID is unset, skipping...";
    exit 1;
fi

# Assemble arguments
ARGS="+force_install_dir \"/server/\" +login anonymous +app_update ${APP_ID}"

# Add validation if requested
if [ ! -z "$VALIDATE" ]
then
    ARGS="${ARGS} validate"
fi

# Add +quit to close steamcmd after download completes
ARGS="${ARGS} +quit"

# Execute steamcmd
steamcmd $ARGS;

exit 0;
