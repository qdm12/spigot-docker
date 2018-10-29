ARG ALPINE_VERSION=3.8

FROM alpine:${ALPINE_VERSION} AS builder
ARG SPIGOT_VERSION=1.13.2
RUN V_ALPINE="v$(cat /etc/alpine-release | grep -oE '[0-9]+\.[0-9]+')" && \
    echo https://dl-3.alpinelinux.org/alpine/$V_ALPINE/community > /etc/apk/repositories && \
    echo https://dl-3.alpinelinux.org/alpine/$V_ALPINE/main >> /etc/apk/repositories && \
    apk --update --no-cache --progress -q add openjdk8-jre git wget ca-certificates
RUN wget -q https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
#RUN git config --global --unset core.autocrlf
RUN java -jar BuildTools.jar --rev ${SPIGOT_VERSION}

FROM alpine:$ALPINE_VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG SPIGOT_VERSION=1.13.2
LABEL org.label-schema.schema-version="1.0.0-rc1" \
      maintainer="quentin.mcgaw@gmail.com" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/qdm12/spigot-docker" \
      org.label-schema.url="https://github.com/qdm12/spigot-docker" \
      org.label-schema.vcs-description="Lightweight Minecraft Spigot $SPIGOT_VERSION server container" \
      org.label-schema.vcs-usage="https://github.com/qdm12/spigot-docker/blob/master/README.md#setup" \
      org.label-schema.docker.cmd="docker run -d -p 25565:25565/tcp -v ./spigot:/spigot -e ACCEPT_EULA=true qmcgaw/spigot" \
      org.label-schema.docker.cmd.devel="docker run -it --rm -p 25565:25565/tcp -v ./spigot:/spigot -e ACCEPT_EULA=true qmcgaw/spigot" \
      org.label-schema.docker.params="ACCEPT_EULA=true or false to accept the EULA license,JAVA_OPTS=Java options to run the Spigot server" \
      org.label-schema.version="Spigot 1.13.2" \
      image-size="130MB" \
      ram-usage="500MB" \
      cpu-usage="Medium"
RUN V_ALPINE="v$(cat /etc/alpine-release | grep -oE '[0-9]+\.[0-9]+')" && \
    echo https://dl-3.alpinelinux.org/alpine/$V_ALPINE/community > /etc/apk/repositories && \
    echo https://dl-3.alpinelinux.org/alpine/$V_ALPINE/main >> /etc/apk/repositories && \
    apk --update --no-cache --progress -q add openjdk8-jre && \
    rm -rf /var/cache/apk/*
ENV JAVA_OPTS -Xms512m -Xmx1800m -XX:+UseConcMarkSweepGC \
    ACCEPT_EULA=false
COPY --from=builder "/spigot-$SPIGOT_VERSION.jar" .
VOLUME /spigot
WORKDIR /spigot
ENTRYPOINT ln -sf "../spigot-$SPIGOT_VERSION.jar" "spigot-$SPIGOT_VERSION.jar" && \
           echo "eula=$ACCEPT_EULA" > eula.txt && \
           java -jar "spigot-$SPIGOT_VERSION.jar" nogui
