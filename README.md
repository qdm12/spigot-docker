# Spigot Docker

[![Spigot Docker](https://github.com/qdm12/spigot-docker/raw/master/readme/title.png)](https://hub.docker.com/r/qmcgaw/spigot)

[![Build Status](https://travis-ci.org/qdm12/spigot-docker.svg?branch=master)](https://travis-ci.org/qdm12/spigot-docker)

[![](https://images.microbadger.com/badges/image/qmcgaw/spigot.svg)](https://microbadger.com/images/qmcgaw/spigot)
[![](https://images.microbadger.com/badges/version/qmcgaw/spigot.svg)](https://microbadger.com/images/qmcgaw/spigot)


| Download size | Image size | RAM usage | CPU usage |
| --- | --- | --- | --- |
| 53.9MB | ?MB | 300MB | Medium |

Based on:
- Alpine Linux
- OpenJDK JRE 8

## Installation

### Spigot MC

[![Spigot](https://github.com/qdm12/spigot-docker/raw/master/readme/spigot.png)](https://www.spigotmc.org)

- Option 1 of 2: Create a Spigot Server from nothing
    1. Download the latest [Buildtools](https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar).
    1. Follow the instructions to build **spigot-X.XX.X.jar** on [https://www.spigotmc.org/wiki/buildtools/](https://www.spigotmc.org/wiki/buildtools/) on your machine.
    1. From here, let the host path to your Spigot MC server directory be `/yourpath/spigot`.
    1. Once the **spigot-X.XX.X.jar** is created, move it in the directory `/yourpath/spigot`.
    1. In the directory `my/path/spigot`, create a file *eula.txt* with the content `eula=true` to accept the SpigotMC license.
- Option 2 of 2: You already have a Spigot MC server directory
    1. From here, let the host path to your Spigot MC server directory be `/yourpath/spigot`
    1. Move your server files to `/yourpath/spigot`
    
### Launching the Docker container

Enter the following and change `yourpath` and optionally the port mapping `25565:25565`

```bash
sudo docker run -d --name=spigot --restart=always -p 25565:25565 \
-v '/yourpath/spigot:/spigot' qmcgaw/spigot
```

### Others

I recommend using the [Hibernate plugin](https://www.spigotmc.org/resources/hibernate.4441/) for your Spigot Docker server

[![Hibernate plugin](readme/hibernate.png)](https://www.spigotmc.org/resources/hibernate.4441/)
