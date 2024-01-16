# echo 'Starting mariadb...'
# service mariadb start;

# sleep 1

# mariadb -e root -p$SQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" || { echo 'Error: fail to create database' >&2; exit 1; }

# echo 'Database creation successfull'


# mariadb -e root -p$SQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo 'Error: fail to create user' >&2; exit 1; }

# echo 'User created with success'


# mariadb -e root -p$SQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo 'Error: fail to grants all privileges on database for user' >&2; exit 1; }

# echo "User ${SQL_USER} has now all privileges"


# mariadb -e root -p$SQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" || { echo 'Error: fail set new password for root' >&2; exit 1; }

# echo 'New password for root set with success'

# mariadb -e root -p$SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;" || { echo 'Error: fail to actualise privileges' >&2; exit 1; }

# systemctl stop mariadb

# exec mysqld_safe

# echo 'Starting mariadb...'
# service mariadb start;

# sleep 1

# mariadb -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" || { echo 'Error: fail to create database' >&2; exit 1; }

# echo 'Database creation successfull'

# mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo 'Error: fail to create user' >&2; exit 1; }

# echo 'User created with success'

# mariadb -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo 'Error: fail to grants all privileges on database for user' >&2; exit 1; }

# echo "User ${SQL_USER} has now all privileges"

# mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" || { echo 'Error: fail set new password for root' >&2; exit 1; }

# echo 'New password for root set with success'

# mariadb -e "FLUSH PRIVILEGES;" || { echo 'Error: fail to actualise privileges' >&2; exit 1; }

# mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown


# exec mysqld_safe

#!/bin/bash

echo 'Starting mariadb...'
mysqld &
sleep 1

mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" || { echo 'Error: fail to create database' >&2; exit 1; }

echo 'Database creation successful'

mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo 'Error: fail to create user' >&2; exit 1; }

echo 'User created successfully'

mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo 'Error: fail to grant all privileges on database for user' >&2; exit 1; }

echo "User ${SQL_USER} now has all privileges"

mysql -u root -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" || { echo 'Error: fail to set new password for root' >&2; exit 1; }

echo 'New password for root set successfully'

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

exec mysqld_safe


