FROM ich777/winehq-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/RHMTT/docker-ams2"

ENV DATA_DIR="/ams2"
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USER="ams2"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
ADD /config/ /tmp/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
