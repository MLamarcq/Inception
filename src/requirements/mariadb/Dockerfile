FROM debian:bullseye

LABEL version="v1.0.0"
LABEL description="Database MariaDB"
LABEL owner="mlamarcq"

WORKDIR /app

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y mariadb-server mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /var/run/mysqld \
	&& mkdir -p /var/lib/mysql \
	&& chown mysql:mysql /var/run/mysqld/ \
	&& chmod -R 755 /var/run/mysqld/ \
	&& chown mysql:mysql /var/lib/mysql/ \
	&& chmod -R 755 /var/lib/mysql/

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/script.sh ./

RUN chmod +x ./script.sh

EXPOSE 3306

ENTRYPOINT ["bash", "script.sh"]

