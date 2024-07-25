FROM	alpine:3.19

ENV WORDPRESS_VERSION=6.5.5
ENV WORDPRESS_SHA1=8d6a705f1b59367ec584a5fd4ab84aa53dd01c85
ENV USER=inception
ENV GROUP=inception

RUN apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-pdo_mysql \
    php81-session \
    php81-json \
    php81-mbstring \
    php81-openssl \
    php81-phar \
    php81-iconv \
    php81-ctype \
    php81-curl \
    php81-xml \
    php81-zip \
    php81-gd \
    php81-dom \
    php81-simplexml \
    php81-tokenizer \
    php81-xmlwriter \
    php81-fileinfo \
    php81-xmlreader \
    php81-pdo \
    php81-pdo_pgsql \
    php81-pdo_sqlite \
    php81-pgsql \
    php81-sqlite3 \
	php81-redis \
	mariadb-client \
    curl \
    less \
    bash && mkdir -p /var/www


# Download and verify WordPress
RUN cd /var/www && curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o adminer.php\
	# && mv adminer-4.8.1.php /var/www/html/index.php \
	&& addgroup -S $GROUP && adduser -S $USER -G $GROUP \
	&& echo "Installed Adminer"

RUN mkdir -p /etc/php81/conf.d \
	&& echo "cgi.fix_pathinfo=0" > /etc/php81/conf.d/00_adminer.ini

RUN chown -R inception:inception /var/www && chmod 755 /var/www/adminer.php

COPY conf/php-fpm.conf /etc/php81/php-fpm.conf
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY tools/setup_adminer.sh /usr/local/bin/setup_adminer.sh

RUN chmod +x /usr/local/bin/setup_adminer.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/setup_adminer.sh" ]