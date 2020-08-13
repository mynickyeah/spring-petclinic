FROM mysql:5.7 AS builder
ARG MYSQL_USER
ARG MYSQL_NAME
ARG MYSQL_PASS
ARG MYSQL_ROOT_PASSWORD
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_DATABASE=${MYSQL_NAME}
ENV MYSQL_PASS=${MYSQL_PASS}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# That file does the MYSQL initialization but also runs mysql daemon, by removing the last line it will only init
RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]

# needed for intialization

COPY setup.sql /docker-entrypoint-initdb.d/
COPY setup.sh /
RUN ["/bin/bash", "-c", "/setup.sh"]

# Need to change the datadir to something else that /var/lib/mysql because the parent docker file defines it as a volume.
# https://docs.docker.com/engine/reference/builder/#volume :
#       Changing the volume from within the Dockerfile: If any build steps change the data within the volume after
#       it has been declared, those changes will be discarded.
RUN ["/usr/local/bin/docker-entrypoint.sh", "mysqld", "--datadir", "/initialized-db"]

FROM mysql:latest

COPY --from=builder /initialized-db /var/lib/mysql
EXPOSE 3306:3306
