FROM debian:latest
ENV PUID=1000 PGID=1000 PATH="/home/steam:${PATH}"
ENV APP_ID= START_CMD=

RUN useradd -m steam -u 1000
WORKDIR /home/steam

RUN dpkg --add-architecture i386

# Install dependencies
RUN apt update && apt upgrade -y && apt install -y --no-install-suggests lib32stdc++6 lib32gcc-s1 curl ca-certificates

# Install steamcmd
RUN su -c 'curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -' -p steam
RUN mv steamcmd.sh steamcmd
RUN su -c "steamcmd +quit" -p steam

RUN mkdir /server && chown steam:steam /server
VOLUME /server
WORKDIR /server

# Copy scripts into container
ADD scripts/* /scripts/
ADD entrypoint.sh /
ADD splash.txt /
RUN chmod -R +x /scripts/*.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]