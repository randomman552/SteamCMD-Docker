FROM debian
ENV PUID=1000 \
    PGID=1000 \
    PATH="/home/steam:${PATH}" \
    APP_ID= \
    START_CMD= 

# Copy scripts into container
ADD scripts /scripts/
ADD health.sh entry.sh splash.txt /

# Add user
RUN useradd -m steam -u ${PUID}
WORKDIR /home/steam

RUN \
    # Install dependencies
        dpkg --add-architecture i386 \
        && apt-get update \
        && apt upgrade -y \
        && apt-get install -y --no-install-recommends --no-install-suggests \
            ca-certificates \
            lib32tinfo6 \
            lib32stdc++6 \
            curl \
            net-tools \
        && apt clean \
        && rm -rf /var/lib/apt/lists/* \
    # Install steamcmd
        && su -c 'curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -' -p steam \
        && mv steamcmd.sh steamcmd \
        && su -c "steamcmd +quit" -p steam \
    # Make /server directory
        && mkdir /server \
        && chown steam:steam /server \
    # Make scripts executable
        && chmod -R +x /scripts/*.sh /*.sh

VOLUME /server
WORKDIR /server

HEALTHCHECK CMD [ "/health.sh" ]
ENTRYPOINT [ "/entry.sh" ]