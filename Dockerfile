# syntax=docker/dockerfile:1
FROM --platform=${BUILDPLATFORM} maven:3.9.11-eclipse-temurin-17-noble AS base

# renovate: datasource=github-releases depName=magefree/mage
ARG UPSTREAM_VERSION=xmage_1.4.58V1
ADD https://github.com/magefree/mage.git#${UPSTREAM_VERSION} /opt/xmage

FROM base AS test

WORKDIR /opt/xmage
# https://github.com/magefree/mage/blob/master/.travis.yml#L11
RUN --mount=type=cache,target=/root/.m2 mvn test -B \
  -Dxmage.dataCollectors.printGameLogs=false \
  -Dlog4j.configuration=file:/opt/xmage/.travis/log4j.properties

FROM base AS build

WORKDIR /opt/xmage
RUN --mount=type=cache,target=/root/.m2 mvn clean install -DskipTests

WORKDIR /opt/xmage/Mage.Server
RUN --mount=type=cache,target=/root/.m2 mvn package assembly:single

FROM --platform=${BUILDPLATFORM} eclipse-temurin:8u462-b08-jre-noble AS jre

FROM jre AS extract
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get -y update \
  && apt-get install -y --no-install-recommends unzip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
COPY --from=build /opt/xmage/Mage.Server/target/mage-server.zip .
RUN unzip mage-server.zip -d /opt/xmage

FROM jre AS final

WORKDIR /opt/xmage
COPY --from=extract /opt/xmage .
COPY entrypoint.sh .

EXPOSE 17171 17179
VOLUME /opt/xmage/db

ENTRYPOINT ["/opt/xmage/entrypoint.sh"]
