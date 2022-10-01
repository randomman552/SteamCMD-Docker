#! /bin/sh
usermod -u ${PUID} steam
groupmod -g ${PGID} steam
chown -R steam:steam /server