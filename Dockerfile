FROM alpine:3.8 AS builder
RUN echo https://dl-3.alpinelinux.org/alpine/v3.8/community > /etc/apk/repositories && \
    echo https://dl-3.alpinelinux.org/alpine/v3.8/main >> /etc/apk/repositories && \
    apk --update add openjdk8-jre git wget ca-certificates
RUN wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
#RUN git config --global --unset core.autocrlf
RUN java -jar BuildTools.jar --rev 1.13.2

FROM alpine:3.8
LABEL maintainer="quentin.mcgaw@gmail.com" \
      description="Lightweight Minecraft Spigot 1.13.2 server container" \
      download="?MB" \
      size="132MB" \
      ram="300MB" \
      cpu_usage="Medium" \
      github="https://github.com/qdm12/spigot-docker"
RUN echo https://dl-3.alpinelinux.org/alpine/v3.8/community > /etc/apk/repositories && \
    echo https://dl-3.alpinelinux.org/alpine/v3.8/main >> /etc/apk/repositories && \
    apk --update add openjdk8-jre
ENV JAVA_OPTS -Xms512m -Xmx1800m -XX:+UseConcMarkSweepGC
COPY --from=builder /spigot-1.13.2.jar .
ENV ACCEPT_EULA=false
VOLUME /spigot
WORKDIR /spigot
ENTRYPOINT [ ! -f ../spigot-1.13.2.jar ] || mv ../spigot-1.13.2.jar ./ && \
           [ "$ACCEPT_EULA" != "true" ] || echo "eula=true" > eula.txt && \
           java -jar spigot-1.13.2.jar nogui
