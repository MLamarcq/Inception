#!/bin/bash

sleep 10

if [ ! command -v wp &> /dev/null ]; then
  echo 'Error: the WC-CLI command is not installed. Please do it before continuing' >&2
  exit 1
fi

if [ ! -d /run/php ]; then
	mkdir /run/php || { echo 'Error: Unable to create /run/php directory.' >&2; exit 1; }
fi

cd /var/www/html/wordpress || { echo 'Error: Unable to change to the WordPress directory.' >&2; exit 1; }

echo 'Everything is good, in progress...'

if [ ! -f wp-config.php ]; then

	echo 'We are in the condition'
    wp config create --allow-root \
        --dbname=${SQL_DATABASE} \
        --dbuser=${SQL_USER} \
        --dbpass=${SQL_PASSWORD} \
        --dbhost=${SQL_HOST} \
        --url=https://${DOMAIN_NAME} || { echo 'Error: Unable to configure WordPress database.' >&2; exit 1; }

    echo "Configuration of wordpress core and admin user ..."
    wp core install --allow-root \
        --url=https://${DOMAIN_NAME} \
        --title=${SITE_TITLE} \
        --admin_user=${ADMIN_USER} \
        --admin_password=${ADMIN_PASSWORD} \
        --admin_email=${ADMIN_EMAIL} || { echo 'Error: Unable to install WordPress core and admin user.' >&2; exit 1; }

    echo "Creation of user..."
    wp user create --allow-root \
        ${USER1_LOGIN} ${USER1_MAIL} \
        --user_pass=${USER1_PASS} || { echo 'Error: Unable to create user.' >&2; exit 1; }

    echo "Clean the wordpress cache..."
    wp cache flush --allow-root || { echo 'Warning: Unable to flush WordPress cache.' >&2; }

fi

echo "WordPress Installation done !"

exec /usr/sbin/php-fpm7.4 -F -R
# #!/bin/bash

# log() {
#     echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
# }

# check_wp_cli() {
#     if ! command -v wp &> /dev/null; then
#         log 'Error: WP-CLI is not installed. Please install it before continuing.'
#         exit 1
#     fi
# }

# create_run_php_directory() {
#     if [ ! -d /run/php ]; then
#         mkdir -p /run/php || { log 'Error: Unable to create /run/php directory.'; exit 1; }
#     fi
# }

# change_to_wordpress_directory() {
#     cd /var/www/html || { log 'Error: Unable to change to the WordPress directory.'; exit 1; }
# }

# configure_wordpress() {
#     log "Configuring WordPress database..."
#     wp config create --allow-root \
#         --dbname=${SQL_DATABASE} \
#         --dbuser=${SQL_USER} \
#         --dbpass=${SQL_PASSWORD} \
#         --dbhost=${SQL_HOST} \
#         --url=https://${DOMAIN_NAME} || { log 'Error: Unable to configure WordPress database.'; exit 1; }

#     log "Configuring WordPress core and admin user..."
#     wp core install --allow-root \
#         --url=https://${DOMAIN_NAME} \
#         --title=${SITE_TITLE} \
#         --admin_user=${ADMIN_USER} \
#         --admin_password=${ADMIN_PASSWORD} \
#         --admin_email=${ADMIN_EMAIL} || { log 'Error: Unable to install WordPress core and admin user.'; exit 1; }

#     log "Creating user..."
#     wp user create --allow-root \
#         ${USER1_LOGIN} ${USER1_MAIL} \
#         --user_pass=${USER1_PASS} --path='/var/www/wordpress' >> /var/www/keys.txt || { log 'Error: Unable to create user.'; exit 1; }

#     log "Cleaning the WordPress cache..."
#     wp cache flush --allow-root || { log 'Warning: Unable to flush WordPress cache.'; }
# }

# main() {
#     log "Script execution started."

#     sleep 10

#     check_wp_cli
#     create_run_php_directory
#     change_to_wordpress_directory

#     if ! wp core is-installed --allow-root; then
#         configure_wordpress
#         log "WordPress installation done!"
#     fi

#     exec /usr/sbin/php-fpm7.4 -F -R
# }

# main


# !/bin/bash

# if [ ! -d /run/php ]; then
# 	mkdir /run/php;
# fi

# cd /var/www/html/wordpress

# if ! wp core is-installed --allow-root; then

# wp config create	--allow-root \
# 			--dbname=${SQL_DATABASE} \
# 			--dbuser=${SQL_USER} \
# 			--dbpass=${SQL_PASSWORD} \
# 			--dbhost=${SQL_HOST} \
# 			--url=https://${DOMAIN_NAME};

# wp core install	--allow-root \
# 			--url=https://${DOMAIN_NAME} \
# 			--title=${SITE_TITLE} \
# 			--admin_user=${ADMIN_USER} \
# 			--admin_password=${ADMIN_PASSWORD} \
# 			--admin_email=${ADMIN_EMAIL};


# wp user create		--allow-root \
# 			${USER1_LOGIN} ${USER1_MAIL} \
# 			--user_pass=${USER1_PASS} ;

# wp cache flush --allow-root


# fi

# exec /usr/sbin/php-fpm7.4 -F -R