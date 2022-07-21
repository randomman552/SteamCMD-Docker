# SteamCMD-Docker
SteamCMD in a Debian based Docker container.\
Designed to be extended by other containers to install specific dedicated servers.\
For example, I have extended this image to build a [GMod container](https://github.com/randomman552/GMod-Docker)

Can also be used in a standalone way to install an app to a directory using a volume or bind mount.

Currently does not support non-anonymous login.

## File structure
The file structure within the container is as follows:
```
📁home/
├─ 📁steam/
│  ├─ 📜steamcmd
📁server/
├─ Server files here
📁scripts/
├─ Scripts here
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

## Extending this image
This image is designed to be extended to produce environments for other dedicated servers.\
For example, I have built an image for GMod which can be found [here](https://github.com/randomman552/GMod-Docker).

In order to extend this container you should place any scripts in the `/scripts` directory.\
These will be executed by `entrypoint.sh` in the order in which they are numbered.\
These scripts are included by default:
- `10-install.sh`
- `20-start.sh`

As an example, if you wanted to run another operation between installing and starting a server, you could add a script numbered as ```15-other-task.sh```.

`steamcmd` can be accessed from any of these scripts by calling `steamcmd` as it is on PATH.

This image also contains a [healthcheck script](health.sh) which checks whether the server is available on the port specified by the environment variables.\
This can be replaced to add your own custom health check logic.
