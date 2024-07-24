FROM alpine:3.19

RUN apk update && apk add --no-cache nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir /var/www/sample_site
#todo:transfer static webpage files to volume...
COPY sample_site/ /var/www/sample_site/

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]