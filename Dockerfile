FROM cm2network/steamcmd

RUN mkdir /home/steam/server

COPY ./install_server.txt /home/steam/server/install_server.txt

RUN /home/steam/steamcmd/steamcmd.sh +runscript /home/steam/server/install_server.txt
 
USER root

RUN adduser --disabled-password --home /home/container container

RUN cp -r /home/steam/server /home/container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
