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

echo "MariaDB is ready "

echo "Waiting for Redis to be ready..."
while ! nc -z redis 6379; do
	retries=$((retries + 1))
	sleep 1
	if [ $retries -ge $MAX_RETRIES ]; then
		echo "Reached maximum number of retries, exiting..."
		exit 1
	fi
done
echo "Redis is ready "

echo "Waiting for FTP-Server to be ready..."
while ! nc -z ftp-server 21; do
	retries=$((retries + 1))
	sleep 1
	if [ $retries -ge $MAX_RETRIES ]; then
		echo "Reached maximum number of retries, exiting..."
		exit 1
	fi
done
echo "FTP-Server is ready "

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	/usr/local/bin/wp-cli.phar config create --allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

/usr/local/bin/wp-cli.phar core install --allow-root \
										--title=$WORDPRESS_TITLE \
										--admin_user=$WP_ADMIN_USER \
										--admin_password=$ADMIN_PASSWORD \
										--admin_email=$ADMIN_EMAIL \
										--url=$DOMAIN_NAME \
										--path='/var/www/wordpress'

chmod -R 755 /var/www/wordpress

#setup redis
/usr/local/bin/wp-cli.phar config set WP_REDIS_HOST redis --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar config set WP_REDIS_PORT 6379 --raw --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar config set WP_REDIS_CLIENT phpredis --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar plugin install redis-cache --activate --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar plugin update --all --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar redis enable --allow-root --path='/var/www/wordpress'

# debug mode for wordpress
/usr/local/bin/wp-cli.phar config set WP_DEBUG_LOG true --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar config set WP_DEBUG true --allow-root --path='/var/www/wordpress'
/usr/local/bin/wp-cli.phar config set SCRIPT_DEBUG true --allow-root --path='/var/www/wordpress'

/usr/local/bin/wp-cli.phar user create $WP_USERNAME $WP_USER_MAIL --role=editor --user_pass=$WP_USER_PASSWORD --path='/var/www/wordpress'

exec /usr/sbin/php-fpm81 -F