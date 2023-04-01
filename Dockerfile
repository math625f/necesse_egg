FROM cm2network/steamcmd

WORKDIR /home/steam

RUN mkdir server

RUN ./steamcmd.sh @ShutdownOnFailedCommand 1 @NoPromptForPassword 1 force_install_dir /home/steam/server login anonymous app_update ${APP_ID} validate quit
 
USER root

RUN adduser --disabled-password --home /home/container container

RUN cp /home/steam/server /home/container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
