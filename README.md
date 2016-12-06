[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

#linuxserver/ubooquity

Ubooquity is a free, lightweight and easy-to-use home server for your comics and ebooks. Use it to access your files from anywhere, with a tablet, an e-reader, a phone or a computer.


[![ubooquity](https://raw.githubusercontent.com/chbmb/docker-templates/master/linuxserver.io/img/ubooquity-icon.png)][ubooquityurl]
[ubooquityurl]: https://vaemendis.net/ubooquity/
Our Plex container has immaculate docs so follow that if in doubt for layout.

`IMPORTANT, replace all instances of <image-name> with the correct dockerhub repo (ie linuxserver/plex) and <container-name> information (ie, plex)`

## Usage

```
docker create \
  --name=uboquity \
  -v <path to data>:/config \
  -v <path to books>:/books \
  -v <path to comics>:/comics \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 2202:2202 \
  linuxserver/ubooquity
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



* `-p 1234` - the port(s)
* `-v /config` - explain what lives here
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it <container-name> /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Insert a basic user guide here to get a n00b up and running with the software inside the container. DELETE ME


## Info

* Shell access whilst the container is running: `docker exec -it ubooquity /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f ubooquity`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' ubooquity`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/ubooquity`

## Versions

+ **06.12.16:** Release 
