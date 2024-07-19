#!/bin/sh
set -e

#if [ "$1" = 'mysqld' ]; then
if [ ! -d /var/lib/mysql/mysql ]; then
	echo 'Initializing database'
	mysql_install_db --user=$MYSQL_USER --datadir=/var/lib/mysql > /dev/null

	echo 'Database initialized'

	mysqld --user=$MYSQL_USER --datadir=/var/lib/mysql --skip-networking &
	pid="$!"

	for i in $(seq 30 -1 0); do
		if echo 'SELECT 1' | mysql -uroot &> /dev/null; then
			break
		fi
		echo 'MariaDB init process in progress...'
		sleep 1
	done

	if [ "$i" = 0 ]; then
		echo >&2 'MariaDB init process failed.'
		exit 1
	fi	

	# create database
	if [ -n "$MYSQL_DATABASE" ]; then
		echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | mysql -uroot
	fi

	if [ -n "$MYSQL_ROOT_USER" ] && [ -n "$MYSQL_ROOT_PASSWORD" ]; then
		echo "CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;" | mysql -uroot
		if [ -n "$MYSQL_DATABASE" ]; then
			echo "GRANT ALL ON *.* TO '$MYSQL_ROOT_USER'@'%' ;" | mysql -uroot
		fi
		echo 'FLUSH PRIVILEGES ;' | mysql -uroot
	fi

	if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
		echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | mysql -uroot
		if [ -n "$MYSQL_DATABASE" ]; then
			echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" | mysql -uroot
		fi
		echo 'FLUSH PRIVILEGES ;' | mysql -uroot
	fi

	kill "$pid"
	wait "$pid"
fi
#fi

#sed -i "skip-networking" /etc/my.cnf.d/mariadb-server.cnf

exec mysqld --user=$MYSQL_USER