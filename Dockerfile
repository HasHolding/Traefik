FROM alpine:latest 
MAINTAINER "Levent SAGIROGLU" <LSagiroglu@gmail.com>
ARG VERSION=v1.5.2

RUN apk add --update --no-cache openssl tar tzdata ca-certificates && \
       update-ca-certificates && \
       cp /usr/share/zoneinfo/Europe/Istanbul /etc/localtime && \
       echo "Europe/Istanbul" >  /etc/timezone && \
    apk del tzdata

VOLUME /srv 
COPY bin /bin
COPY etc/traefik /etc/traefik
WORKDIR /bin
RUN wget https://github.com/containous/traefik/releases/download/${VERSION}/traefik_linux-amd64 -O traefik
RUN chmod +x /bin/traefik
ENV TOML "/etc/traefik/traefik.toml" 
 
EXPOSE 80 443 8080

ENTRYPOINT ["/bin/entrypoint.sh"]
