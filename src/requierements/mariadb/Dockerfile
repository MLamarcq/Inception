FROM debian:bullseye

LABEL version="v1.0.0"
LABEL descritpion="Data base mariaDB"
LABEL owner="mlamarcq"

ARG APP_UID=1000
ARG APP_GID=1000
ARG APP_USER=mlamarcq

RUN addgroup --system --gid $APP_GID $APP_USER \
	&& adduser --system --uid $APP_UID --gid $APP_GID $APP_USER

WORKDIR /app

USER ${APP_USER}:${APP_USER}

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /var/lib/mysql \
	&& chown mysql:mysql /var/run/mysqld/ \
	&& chmod -R 755 /var/run/mysqld/ \
	&& chown mysql:mysql /var/lib/mysql/ \
	&& chmod -R 755 /var/lib/mysql/

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

CMD