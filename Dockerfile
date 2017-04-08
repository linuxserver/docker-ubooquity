FROM lsiobase/alpine:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package version
ARG UBOOQUITY_VER="1.10.1"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	unzip && \

# install runtime packages
 apk add --no-cache \
	openjdk8-jre-base && \

# install ubooquity
 mkdir -p \
	/opt/ubooquity \
	/opt/ubooquity/fonts && \
 curl -o \
 /tmp/ubooquity.zip -L \
	"http://vaemendis.net/ubooquity/downloads/Ubooquity-${UBOOQUITY_VER}.zip" && \
 unzip /tmp/ubooquity.zip -d /opt/ubooquity && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 2202
VOLUME /books /comics /config /files
