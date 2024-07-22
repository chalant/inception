FROM		alpine:3.19

RUN			apk update && apk upgrade && apk add --no-cache \
			openssl \
			nginx \
			curl \
			vim \
			sudo

# todo: key creation should be in a script (to retrieve the environment variables)
RUN			rm -f /etc/nginx/nginx.conf && \
			mkdir /etc/nginx/ssl && \
			openssl req -x509 -nodes \
			-out /etc/nginx/ssl/inception.crt \
			-keyout /etc/nginx/ssl/inception.key \ 
			-subj "/C=FR/ST=IDF/L=Bruxelles/O=42/OU=42/CN=ychalant.42.fr/UID=login"

COPY		conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE		443

CMD	["nginx", "-g", "daemon off;"]