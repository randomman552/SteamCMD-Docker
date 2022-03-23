#! /bin/sh
usermod -u ${PUID} steam
groupmod -g ${PGID} steam
chown steam:steam /home/server
exit 0
