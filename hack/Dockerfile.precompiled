FROM openjdk:8-jre-alpine AS base
WORKDIR /opt/xmage

FROM base AS setup
WORKDIR /tmp

RUN apk add --no-cache -U jq curl && \
    curl --silent --show-error http://xmage.de/xmage/config.json | jq '.XMage.location' | xargs curl -# -L > xmage.zip && \
    unzip xmage.zip -x "mage-client*" &&  \
    rm xmage.zip && \
    apk del curl jq

FROM base AS final
WORKDIR /opt/xmage/server

ENV JAVA_MIN_MEMORY=256M \
    JAVA_MAX_MEMORY=512M \
    XMAGE_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_SERVER_NAME="mage-server" \
    XMAGE_PORT="17171" \
    XMAGE_SECONDARY_BIND_PORT="17179"

EXPOSE 17171 17179

COPY --from=setup /tmp/mage-server ./
COPY docker-entrypoint.sh ./

RUN chmod +x startServer.sh && \
    chmod +x docker-entrypoint.sh

ENTRYPOINT [ "./docker-entrypoint.sh" ]
