# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.20

# set version label
ARG BUILD_DATE
ARG VERSION
ARG UBOOQUITY_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    unzip && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    openjdk17-jre && \
  echo "**** install ubooquity ****" && \
  if [ -z ${UBOOQUITY_VERSION+x} ]; then \
    UBOOQUITY_VERSION=$(curl -IsL -w %{url_effective} -o /dev/null https://vaemendis.net/ubooquity/service/download.php \
    | sed 's|.*Ubooquity-\([0-9\.]*\).zip|\1|'); \
  fi && \
  mkdir -p \
    /app/ubooquity && \
  curl -o \
  /tmp/ubooquity.zip -L \
    "https://vaemendis.net/ubooquity/downloads/Ubooquity-${UBOOQUITY_VERSION}.zip" && \
  unzip /tmp/ubooquity.zip -d /app/ubooquity && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 2202 2203

VOLUME /config
