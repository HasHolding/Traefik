FROM alpine:latest
MAINTAINER "Levent SAGIROGLU" <LSagiroglu@gmail.com>
ARG VERSION=v1.5.2
ARG TIMEZONE=Europe/Istanbul

RUN apk add --update --no-cache openssl tar tzdata ca-certificates &&\
       update-ca-certificates &&\
       cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime &&\
       echo "${TIMEZONE}" >  /etc/timezone &&\
       wget --quiet --output-document=/bin/traefik https://github.com/containous/traefik/releases/download/${VERSION}/traefik_linux-amd64 &&\
       chmod +x /bin/traefik &&\
    apk del tzdata

VOLUME /srv 
COPY bin /bin
COPY etc/traefik /etc/traefik
WORKDIR /bin

ENV TOML "/etc/traefik/traefik.toml" 
 
EXPOSE 80 443 8080

ENTRYPOINT ["/bin/entrypoint.sh"]
