#!/bin/sh

MAX_RETRIES=60

retries=0

echo "Waiting for MariaDB to be ready..."
while ! nc -z mariadb 3306; do
	retries=$((retries + 1))
	sleep 1
	if [ $retries -ge $MAX_RETRIES ]; then
		echo "Reached maximum number of retries, exiting..."
		exit 1
	fi
done

/usr/local/bin/wp-cli.phar config create --allow-root \
				--dbname=$MYSQL_DATABASE \
				--dbuser=$MYSQL_USER \
				--dbpass=$MYSQL_PASSWORD \
				--dbhost=mariadb:3306 --path='/var/www/wordpress'

exec /usr/sbin/php-fpm81 -F