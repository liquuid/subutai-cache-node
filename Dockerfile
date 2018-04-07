FROM coreapps/ubuntu16.04

ENV    TERM xterm

WORKDIR /app
#ADD . /app

RUN     mkdir -p /etc/ssl/certs/ /etc/ssl/private/ /app/cache 

COPY    bootstrap/cdn/nginx-selfsigned.crt /etc/ssl/certs/
COPY    bootstrap/cdn/nginx-selfsigned.key /etc/ssl/private/

RUN     export DEBIAN_FRONTEND=noninteractive && \
        apt-get -y update && \
        apt-get -y dist-upgrade && \
        apt-get -y install nginx 

COPY    bootstrap/cdn/cdn1.conf /etc/nginx/sites-enabled/
COPY    bootstrap/cdn/nginx.conf /etc/nginx/

RUN     mkdir -p /app/cache/deb 
RUN     mkdir -p /app/cache/qry
RUN     mkdir -p /app/cache/raw
RUN     mkdir -p /app/cache/templ 

STOPSIGNAL SIGRTMIN+3
CMD ["/usr/sbin/nginx"] 

# vim: ts=4 et nowrap autoindent
