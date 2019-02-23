FROM lsiobase/alpine:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG UBOOQUITY_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	unzip && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	openjdk8-jre-base && \
 echo "**** install ubooquity ****" && \
 if [ -z ${UBOOQUITY_VERSION+x} ]; then \
	UBOOQUITY_VERSION=$(curl -IsL -w %{url_effective} -o /dev/null http://vaemendis.net/ubooquity/service/download.php \
	| sed 's|.*Ubooquity-\([0-9\.]*\).zip|\1|'); \
 fi && \
 mkdir -p \
	/app/ubooquity && \
 curl -o \
 /tmp/ubooquity.zip -L \
	"http://vaemendis.net/ubooquity/downloads/Ubooquity-${UBOOQUITY_VERSION}.zip" && \
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
