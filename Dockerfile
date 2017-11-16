FROM alpine:latest 
MAINTAINER "Levent SAGIROGLU" <LSagiroglu@gmail.com>
ARG VERSION=v1.4.3
RUN apk update && \
    apk upgrade && \
    apk add --update openssl && \
    apk add ca-certificates && \
	   update-ca-certificates

VOLUME /srv 
COPY bin /bin
COPY etc/traefik /etc/traefik
WORKDIR /bin
RUN wget https://github.com/containous/traefik/releases/download/${VERSION}/traefik_linux-amd64 -O traefik
RUN chmod +x /bin/traefik
ENV TOML "/etc/traefik/traefik.toml" 
 
EXPOSE 80 443 8080

ENTRYPOINT ["/bin/entrypoint.sh"]
