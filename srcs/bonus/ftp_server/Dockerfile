FROM alpine:3.19

RUN apk update && apk upgrade && apk add --no-cache vsftpd bash
# RUN mkdir -p /var/ftp


COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/setup_ftp.sh /usr/local/bin/setup_ftp.sh

EXPOSE 21 30000-30009

RUN chmod +x /usr/local/bin/setup_ftp.sh

ENTRYPOINT [ "/usr/local/bin/setup_ftp.sh" ]