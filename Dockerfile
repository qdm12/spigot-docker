FROM openjdk:8-jre-alpine
LABEL maintainer="quentin.mcgaw@gmail.com" \
      description="VPN client container to private internet access servers based on Alpine Linux and OpenVPN" \
      download="53.9MB" \
      size="?MB" \
      ram="300MB" \
      cpu_usage="Medium" \
      github="https://github.com/qdm12/spigot-docker"
RUN mkdir /spigot
ENV JAVA_OPTS -Xms512m -Xmx1800m
ENTRYPOINT java -jar /spigot/spigot-1.12.2.jar
CMD ["nogui"]