#! /bin/sh
usermod -u ${PUID} steam
groupmod -g ${PGID} steam
chown steam:steam /server