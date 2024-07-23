FROM    alpine:3.19

# add redis user and group with current host userid and groupid
RUN apk update && apk upgrade && apk add --update --no-cache libc6-compat \
 	&& rm -f /var/cache/apk/* \
 	&&  mkdir -p /var/run/docker \
	&&     wget -O /usr/local/bin/cadvisor "https://github.com/google/cadvisor/releases/download/v0.45.0/cadvisor-v0.45.0-linux-amd64" \
	&&     chmod +x /usr/local/bin/cadvisor

EXPOSE  8080

# launch command as non root

CMD     ["/usr/local/bin/cadvisor", "-logtostderr"]