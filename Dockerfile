FROM alpine:latest
MAINTAINER valen@limanto.net

RUN apk update && apk add kamailio sqlite kamailio-sqlite kamailio-tls rtpproxy

RUN sed -i -e 's/.*mi_fifo.*//' /etc/kamailio/kamailio.cfg

RUN sed -i -e 's/.*SIP_DOMAIN.*/SIP_DOMAIN=limanto.net/; s/.*DBENGINE.*/DBENGINE=SQLITE/; s/.*DB_PATH.*/DB_PATH="db.sqlite"/' /etc/kamailio/kamctlrc

RUN echo "y\ny" | kamdbctl create db.sqlite

RUN kamctl add valen password123

EXPOSE 5060/udp
EXPOSE 5060/tcp

CMD ["kamailio","-DD","start"]
