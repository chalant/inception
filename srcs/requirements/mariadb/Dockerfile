FROM alpine:3.19

# Set environment variables for MariaDB
# ENV	MARIADB_VERSION=10.6.12-r0 \
#     MYSQL_ROOT_PASSWORD=rootpassword \
#     MYSQL_DATABASE=mydatabase \
#     MYSQL_USER=myuser \
#     MYSQL_PASSWORD=mypassword

# Install MariaDB and other necessary packages
RUN apk update \
	&& apk add --no-cache mariadb mariadb-client \
	&& addgroup -S inception && adduser -S inception -G inception

RUN mkdir -p /run \
	&& mkdir -p /etc/mysql \
	&& mkdir -p /etc/mysql/cond.d \
	&& mkdir -p /run/mysqld \
	&& chown -R inception:inception /run

COPY	conf/mariadb_conf.sh /usr/local/bin/
COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY conf/50-server.cnf /etc/mysql/conf.d/50-server.cnf
RUN	chmod +x /usr/local/bin/mariadb_conf.sh

EXPOSE		3306

ENTRYPOINT	["/usr/local/bin/mariadb_conf.sh"]