# Spigot Docker

[![Spigot Docker](readme/title.png)](https://hub.docker.com/u/qmcgaw/spigot)

Based on:
- Alpine Linux
- OpenJDK JRE 8

It uses 300MB of RAM and a low percentage of CPU

## Installation

### Spigot MC

[![Spigot](readme/spigot.png)](https://www.spigotmc.org)

- Option 1 of 2: Create a Spigot Server from nothing
    1. Download the latest [Buildtools](https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar).
    2. Follow the instructions to build **spigot-X.XX.X.jar** on [https://www.spigotmc.org/wiki/buildtools/](https://www.spigotmc.org/wiki/buildtools/) on your machine.
    3. From here, let the host path to your Spigot MC server directory be `my/path/spigot`.
    4. Once the **spigot-X.XX.X.jar** is created, move it in the directory `my/path/spigot`.
    5. In the directory `my/path/spigot`, create a file *eula.txt* with the content `eula=true` to accept the SpigotMC license.
- Option 2 of 2: You already have a Spigot MC server directory
    1. From here, let the host path to your Spigot MC server directory be `my/path/spigot`
    2. Move your server files to `my/path/spigot`
    
### Obtaining the Docker image

- Option 1 of 2: Obtain from Docker Hub
    
    [![Docker container](readme/docker.png)](https://www.docker.com/)
    
    ```bash
    sudo docker pull qmcgaw/spigot-docker
    ```
    
- Option 2 of 2: Build the image
    1. Download the repository files
    2. With a terminal, change to the directory of the repository
    3. Enter the following:
        ```bash
        sudo docker build -t qmcgaw/spigot ./
        ```

### Launching the Docker container from the image

1. Enter the following line to test the server interactively:
    ```bash
    sudo docker run -it --rm --name=spigotTEST -v '/my/path/spigot:/usr/src/spigot' -p 35565:25565 qmcgaw/spigot
    ```
    
    Note that you can change `/my/path/spigot` to another path where your server files are.
    
    We bind the host port **35565** to the minecraft default server port **25565**. You can change that.
    
2. To run the server as a daemon:

    ```bash
    sudo docker run -d --name=spigot --restart=always -v '/my/path/spigot:/usr/src/spigot' -p 37050:25565 qmcgaw/spigot
    ```

### Others

I recommend using the [Hibernate plugin](https://www.spigotmc.org/resources/hibernate.4441/) for your Spigot Docker server

[![Hibernate plugin](readme/hibernate.png)](https://www.spigotmc.org/resources/hibernate.4441/)