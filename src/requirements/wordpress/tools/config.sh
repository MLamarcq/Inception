#!/bin/bash

#definition of log function that print a message on the standard output with date and hour of the command execution
log()
{
	echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}

sleep 10

if [ ! command -v wp &> /dev/null ]; then
  log 'Error: the WC-CLI command is not installed. Please do it before continuing' >&2
  exit 1
fi

if [ ! -d /run/php ]; then
	mkdir /run/php || { log 'Error: Unable to create /run/php directory.' >&2; exit 1; }
fi

cd /var/www/html/wordpress || { log 'Error: Unable to change to the WordPress directory.' >&2; exit 1; }

log 'Everything is good, in progress...'

if [ ! -f wp-config.php ]; then

	wp config create --allow-root \
		--dbname=${SQL_DATABASE} \
		--dbuser=${SQL_USER} \
		--dbpass=${SQL_PASSWORD} \
		--dbhost=${SQL_HOST} \
		--url=https://${DOMAIN_NAME} || { log 'Error: Unable to configure WordPress database.' >&2; exit 1; }

	log "Configuration of wordpress core and admin user ..."
	wp core install --allow-root \
		--url=https://${DOMAIN_NAME} \
		--title=${SITE_TITLE} \
		--admin_user=${ADMIN_USER} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL} || { log 'Error: Unable to install WordPress core and admin user.' >&2; exit 1; }

	log "Creation of user..."
	wp user create --allow-root \
		${USER1_LOGIN} ${USER1_MAIL} \
		--user_pass=${USER1_PASS} || { log 'Error: Unable to create user.' >&2; exit 1; }

	log "Clean the wordpress cache..."
	wp cache flush --allow-root || { log 'Warning: Unable to flush WordPress cache.' >&2; }

fi

log "WordPress Installation done !"

exec /usr/sbin/php-fpm7.4 -F -R