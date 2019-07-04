[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/ubooquity](https://github.com/linuxserver/docker-ubooquity)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/ubooquity.svg)](https://microbadger.com/images/linuxserver/ubooquity "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/ubooquity.svg)](https://microbadger.com/images/linuxserver/ubooquity "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/ubooquity.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/ubooquity.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-ubooquity/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-ubooquity/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/ubooquity/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/ubooquity/latest/index.html)

[Ubooquity](https://vaemendis.net/ubooquity/) is a free, lightweight and easy-to-use home server for your comics and ebooks. Use it to access your files from anywhere, with a tablet, an e-reader, a phone or a computer.

[![ubooquity](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/ubooquity-banner.png)](https://vaemendis.net/ubooquity/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/ubooquity` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=ubooquity \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e MAXMEM=<maxmem> \
  -p 2202:2202 \
  -p 2203:2203 \
  -v <path to data>:/config \
  -v <path to books>:/books \
  -v <path to comics>:/comics \
  -v <path to raw files>:/files \
  --restart unless-stopped \
  linuxserver/ubooquity
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  ubooquity:
    image: linuxserver/ubooquity
    container_name: ubooquity
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - MAXMEM=<maxmem>
    volumes:
      - <path to data>:/config
      - <path to books>:/books
      - <path to comics>:/comics
      - <path to raw files>:/files
    ports:
      - 2202:2202
      - 2203:2203
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 2202` | The library port. |
| `-p 2203` | The admin port. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e MAXMEM=<maxmem>` | To set the maximum memory. ( ex: set '1024' for 1GB ) |
| `-v /config` | Config files and database for ubooquity. |
| `-v /books` | Location of books. |
| `-v /comics` | Location of comics. |
| `-v /files` | Location of raw files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

**IMPORTANT**
Ubooquity has now been upgraded to [version 2](http://vaemendis.net/ubooquity/article19/ubooquity-2-1-0) and for existing v1.x users we recommend cleaning your appdata and reinstalling, due to changes in the application itself making the two versions essentially incompatible with each other. Also the admin page and library pages are now on separate ports as detailed below.

Access the admin page at `http://<your-ip>:2203/ubooquity/admin` and set a password.

Then you can access the webui at `http://<your-ip>:2202/ubooquity/`

This container will automatically scan your files at startup.

### MAXMEM

The quantity of memory allocated to Ubooquity depends on the hardware your are running it on. If this quantity is too small, you might sometime saturate it with when performing memory intensive operations. That’s when you get `java.lang.OutOfMemoryError:` Java heap space errors.

You can explicitly set the amount of memory Ubooquity is allowed to use (be careful to set a value lower than the actual physical memory of your hardware). Value is a number of megabytes ( put just a number, without MB )

If no value is set it will default to 512MB.



## Support Info

* Shell access whilst the container is running: `docker exec -it ubooquity /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f ubooquity`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' ubooquity`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/ubooquity`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/ubooquity`
* Stop the running container: `docker stop ubooquity`
* Delete the container: `docker rm ubooquity`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start ubooquity`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull ubooquity`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d ubooquity`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once ubooquity
  ```

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using Docker Compose.

* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-ubooquity.git
cd docker-ubooquity
docker build \
  --no-cache \
  --pull \
  -t linuxserver/ubooquity:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **22.02.19:** - Rebasing to alpine 3.9.
* **28.01.19:** - Add pipeline logic and multi arch.
* **15.10.18:** - Upgrade to Ubooquity 2.1.2.
* **23.08.18:** - Rebase to alpine 3.8.
* **09.12.17:** - Rebase to alpine 3.7.
* **07.10.17:** - Upgrade to Ubooquity 2.1.1.
* **16.07.17:** - Upgrade to Ubooquity 2.1.0, see setting up application section for important info for existing v1.x users.
* **26.05.17:** - Rebase to alpine 3.6.
* **08.04.17:** - Switch to java from 3.5 repo, fixes login crashes.
* **06.02.17:** - Rebase to alpine 3.5.
* **06.12.16:** - Initial Release.
