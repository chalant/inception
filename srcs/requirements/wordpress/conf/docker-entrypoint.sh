#!/bin/sh

sleep 5

/usr/local/bin/wp-cli.phar config create --allow-root \
				--dbname=$MYSQL_DATABASE \
				--dbuser=$MYSQL_USER \
				--dbpass=$MYSQL_PASSWORD \
				--dbhost=mariadb:3306 --path='/var/www/wordpress'

exec /usr/sbin/php-fpm81 -F