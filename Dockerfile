FROM alpine:latest

RUN apk add --update curl squid && \
	rm -rf /var/cache/apk/* && \
	mkdir /cache

RUN /usr/lib/squid/ssl_crtd -c -s /var/cache/squid/ssl_db && \
	chown -R squid /var/cache/squid/ssl_db

COPY run.sh /usr/local/bin/
COPY squid.conf /etc/squid/

VOLUME "/cache"

EXPOSE 3128

ENTRYPOINT [ "/usr/local/bin/run.sh" ]
