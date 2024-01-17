#definition of log function that print a message on the standard output with date and hour of the command execution
log()
{
	echo "$(date +"%Y-%m-%d %H:%M:%S") - $1"
}
#lauch mariadb by use mysqld function
log 'Starting mariadb...'
mysqld &

#the script is waiting 1 second before starting in order to let a laps of time for mariadb to start correctly
sleep 1

#check if database exist ; else it creates it with the database name referenced in .env file ; exit the program if fail
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" || { log 'Error: fail to create database' >&2; exit 1; }

log 'Database creation successful'

#check if database user exist ; else it creates it with the user name referenced in .env file ; exit the program if fail
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" || { log 'Error: fail to create user' >&2; exit 1; }

log 'User created successfully'

#gives all the privileges to the user in the database and set its password, both referenced in .env file ; exit the program if fail
mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" || { log 'Error: fail to grant all privileges on database for user' >&2; exit 1; }

log "User ${SQL_USER} now has all privileges"

#set a new password for root in the database referenced in .env file ; exit the program if fail
mysql -u root -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" || { log 'Error: fail to set new password for root' >&2; exit 1; }

log 'New password for root set successfully'

#stops mariadb for a safer execution
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

#execute mariadb in a safe way
exec mysqld_safe


