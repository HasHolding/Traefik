FROM alpine:latest 
MAINTAINER "Levent SAGIROGLU" <LSagiroglu@gmail.com>

VOLUME /srv 
ENV TOML "/etc/traefik/traefik.toml" 

COPY entrypoint.sh /bin/entrypoint.sh 
COPY traefik /bin/traefik
COPY  /etc/traefik /etc/traefik


EXPOSE 80 443 8080

ENTRYPOINT ["/bin/entrypoint.sh"]

