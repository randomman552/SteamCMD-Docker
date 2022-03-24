# SteamCMD-Docker
SteamCMD in a Debian based Docker container\
Designed to be extended by other containers to install specific dedicated servers.\
For example, I have extended this image to build a [GMod container](https://github.com/randomman552/GMod-Docker)

Can also be used in a standalone way to install an app to a directory using a volume or bind mount.

Currently does not support non-anonymous login.

## File structure
The file structure within the container is as follows:
```
📁home/
├─ 📁steam/
│  ├─ 📜steamcmd.sh
📁server/
├─ server files here
📁scripts/
├─ 📜entrypoint.sh
├─ 📜fix_permissions.sh
├─ 📜install.sh
├─ 📜start.sh
```

If you wish to preserve the installed server between runs, you should create a volume or a bind mount for the `/server` directory.

## Environment variables
Provides the following environment variables for configuration:
| Variable  | Default value | Description                                        |
|:---------:|:-------------:|:--------------------------------------------------:|
| PUID      | 1000          | ID of user SteamCMD and the server will be run as  |
| PGID      | 1000          | ID of group SteamCMD and the server will be run as |
| APP_ID    |               | ID of app to install                               |
| START_CMD |               | Command used to start server once installed        |

## Running
As an example, I will be using this container to run an unmodded gmod server.\
It is possible to set the APP_ID and START_CMD environment variables to use this container directly, but it is recommended to extend this container and add your own custom scripts and environment variables to handle this functionality.
### Docker CLI
```sh
docker run \
    -e APP_ID=4020 \
    -e START_CMD=/server/srcds_run \
    -p 27015:27015 \
    -v gmod:/server \
    ghcr.io/randomman552/steamcmd
```
### Docker Compose
```yml
version: "3.8"
services:
    steamcmd:
        image: ghcr.io/randomman552/steamcmd
        environment:
            - APP_ID=4020
            - START_CMD=/server/srcds_run
        ports:
            - 27015:27015
        volumes:
            - ./server:/server
```
