FROM alpine:3.19

RUN apk update && apk add --no-cache nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

#todo:transfer static webpage files to volume...

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]