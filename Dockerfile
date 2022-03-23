FROM debian:latest
ENV PUID=1000 PGID=1000
ENV APP_ID= START_CMD=

RUN useradd -m steam -u 1000
WORKDIR /home/steam

RUN dpkg --add-architecture i386

# Install dependencies
RUN apt update && apt upgrade -y && apt install -y --no-install-suggests lib32stdc++6 lib32gcc-s1 curl ca-certificates

# Install steamcmd
RUN runuser -l steam -c 'curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -'
RUN runuser -l steam -c './steamcmd.sh +quit'

RUN mkdir /home/server && chown steam:steam /home/server
WORKDIR /home/server

# Copy scripts into container
ADD scripts/* /scripts/
RUN chmod -R +x /scripts

ENTRYPOINT [ "/scripts/entrypoint.sh" ]