FROM debian:bullseye

LABEL version="v1.0.0"
LABEL owner="mlamarcq"
LABEL descritpion="A wordpress site"

WORKDIR /app

# Installation de wget pour le téléchargement de fichiers
# Installation de PHP 7.4, PHP-FPM et le module PHP pour MySQL
# Installation du client MySQL
RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y wget \
	&& apt-get install -y php7.4 php-fpm php-mysql \
	&& apt-get update && apt-get install -y default-mysql-client mariadb-client \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Installation de WP-CLI (WordPress CLI)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp


# Téléchargement de WordPress et extraction dans le répertoire /var/www/html
RUN wget https://wordpress.org/wordpress-6.4.1.tar.gz -P /var/www/html \
	&& cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.4.1.tar.gz \
	&& rm /var/www/html/wordpress-6.4.1.tar.gz

# Attribution des droits d'accès à l'utilisateur www-data et configuration des permissions
RUN chown -R www-data:www-data /var/www/* \
	&& chmod -R 755 /var/www/*

# Exposition du port 9000
EXPOSE 9000

# Copie du fichier de configuration www.conf dans le répertoire /etc/php/7.4/fpm/pool.d/
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/config.sh ./
RUN chmod +x ./config.sh

# Définition du point d'entrée pour l'exécution du script config.sh
ENTRYPOINT ["bash", "config.sh"]