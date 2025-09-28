# syntax=docker/dockerfile:1

FROM eclipse-temurin:21-jdk

LABEL version="1.8.0"
LABEL homepage.group=Minecraft
LABEL homepage.name="FTB Skies 2"
LABEL homepage.icon="https://cdn.feed-the-beast.com/blob/49/4951517d1bd2376e48d280427f95fd313c7aa778bddff582296651cfae7d7a9a.png"
LABEL homepage.widget.type=minecraft
LABEL homepage.widget.url=udp://FTBSkies:25565

# Create minecraft group and user with UID/GID 99
RUN groupadd -g 99 minecraft && \
    useradd -u 99 -g minecraft -d /data -m -s /bin/bash minecraft && \
    apt-get update && apt-get install -y curl

# Add launch script and set permissions
COPY launch.sh /launch.sh
RUN chmod +x /launch.sh && chown minecraft:minecraft /launch.sh

USER minecraft

VOLUME /data
WORKDIR /data

EXPOSE 25565/tcp

ENV MOTD="FTB Skies 2 1.9.0 Server Powered by Docker"
ENV LEVEL=world
ENV JVM_OPTS="-Xms4096m -Xmx6144m"

CMD ["/launch.sh"]