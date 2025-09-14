# syntax=docker/dockerfile-upstream:master-labs

# https://github.com/magefree/mage/blob/master/pom.xml#L106
FROM maven:3.8.1-openjdk-17 AS base

FROM scratch AS git

# renovate: datasource=github-releases depName=github.com/magefree/mage
ARG UPSTREAM_VERSION=xmage_1.4.57V2

ADD https://github.com/magefree/mage.git#${UPSTREAM_VERSION} /opt/xmage

FROM base AS deps
COPY --from=git --parents **/pom.xml .
COPY --from=git /opt/xmage/repository /opt/xmage/repository

WORKDIR /opt/xmage
RUN --mount=type=cache,target=/root/.m2 mvn clean

FROM base AS test
COPY --from=git /opt/xmage /opt/xmage
WORKDIR /opt/xmage

# https://github.com/magefree/mage/blob/master/.travis.yml#L11
RUN mvn test -B -Dxmage.dataCollectors.printGameLogs=false

FROM deps AS build
COPY --from=git /opt/xmage /opt/xmage

WORKDIR /opt/xmage
RUN mvn install -DskipTests

EXPOSE 17171 17179
