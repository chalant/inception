#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then
	touch /etc/vsftpd/vsftpd.init
	touch /var/log/vsftpd.log
	cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
	adduser -D -h /var/www/wordpress -s /sbin/nologin $FTP_USER
	echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
	chown -R $FTP_USER:$FTP_USER /var/www/wordpress
	chmod -R 755 /var/www/wordpress

	echo $FTP_USER | tee -a /etc/vsftpd.userlist &> /dev/null
fi

echo "Starting ftp-server..."
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf