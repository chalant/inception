#!/bin/sh

MAX_RETRIES=60

retries=0

echo "Waiting for WordPress to be ready..."
while ! nc -z wordpress 9000; do
	retries=$((retries + 1))
	sleep 1
	if [ $retries -ge $MAX_RETRIES ]; then
		echo "Reached maximum number of retries, exiting..."
		exit 1
	fi
done

if [ ! -f "/var/www/wordpress/adminer.php" ]; then
	cd /var/www && mv adminer.php wordpress
fi

rm -f /var/www/adminer.php

/usr/sbin/php-fpm81 -F