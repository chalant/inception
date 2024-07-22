FROM	alpine:3.19

ENV WORDPRESS_VERSION=6.5.5
ENV WORDPRESS_SHA1=8d6a705f1b59367ec584a5fd4ab84aa53dd01c85
ENV USER=inception
ENV GROUP=inception

RUN apk update && apk upgrade && apk add --no-cache \
    php81 \
    php81-fpm \
	php81-opcache \
	php81-gd \
	php81-mysqli \
	php81-cgi \
	php81-phar \
	php81-curl \
	php81-mbstring \
	php81-json \
	php81-session \
	php81-iconv \
	php81-pdo_mysql \
	php81-pecl-redis \
	php81-tokenizer \
	php81-bcmath \
	php81-ctype \
	php81-common \
	php81-redis \
	mariadb-client \
    curl \
    tar \
    bash && mkdir /var/www


# Download and verify WordPress
RUN cd /var/www && curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz" \
    && echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf wordpress.tar.gz \
	&& addgroup -S $GROUP && adduser -S $USER -G $GROUP \
	&& rm wordpress.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp-cli.phar \
	&& ln -s /usr/bin/php81 /usr/bin/php


RUN chown -R inception:inception /var/www/wordpress

COPY conf/php-fpm.conf /etc/php81/php-fpm.conf
COPY conf/docker-entrypoint.sh /usr/local/bin/wordpress-launch.sh

RUN chown root:root /usr/local/bin/wordpress-launch.sh

RUN	chmod +x /usr/local/bin/wordpress-launch.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress-launch.sh"]