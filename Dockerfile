FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# package version
ARG UBOOQUITY_VER="2.1.2"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	unzip && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	openjdk8-jre-base && \
 echo "**** install ubooquity ****" && \
 mkdir -p \
	/app/ubooquity && \
 curl -o \
 /tmp/ubooquity.zip -L \
	"http://vaemendis.net/ubooquity/downloads/Ubooquity-${UBOOQUITY_VER}.zip" && \
 unzip /tmp/ubooquity.zip -d /app/ubooquity && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 2202 2203
VOLUME /books /comics /config /files
