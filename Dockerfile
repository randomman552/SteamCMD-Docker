FROM debian:latest
ENV PUID=1000 PGID=1000
ENV APP_ID= START_CMD=

LABEL org.opencontainers.image.source 'https://github.com/randomman552/SteamCMD-Docker'
LABEL org.opencontainers.image.url 'https://github.com/randomman552/SteamCMD-Docker'
LABEL org.opencontainers.image.documentation 'https://github.com/randomman552/SteamCMD-Docker/blob/main/README.MD'
LABEL org.opencontainers.image.title 'SteamCMD'

RUN useradd -m steam -u 1000
WORKDIR /home/steam

RUN dpkg --add-architecture i386

# Install dependencies
RUN apt update && apt upgrade -y && apt install -y --no-install-suggests lib32stdc++6 lib32gcc-s1 curl ca-certificates

# Install steamcmd
RUN runuser -l steam -c 'curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -'
RUN runuser -l steam -c './steamcmd.sh +quit'

RUN mkdir /server && chown steam:steam /server
VOLUME /server
WORKDIR /server

# Copy scripts into container
ADD scripts/* /scripts/
RUN chmod -R +x /scripts/*.sh

ENTRYPOINT [ "/scripts/entrypoint.sh" ]