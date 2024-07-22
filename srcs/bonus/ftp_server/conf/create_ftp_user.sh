#!/bin/sh

chown -R ftpuser:ftpuser /home/ftpusers/ftpuser
# Add a new FTP user
pure-pw useradd ftpuser -u ftpuser -d /var/www/wordpress

# Apply the changes
pure-pw mkdb

# Start Pure-FTPd with passive mode ports and no anonymous access
/usr/sbin/pure-ftpd -j -E -p 30000:30009 -P localhost -i