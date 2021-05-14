FROM adoptopenjdk:11-jre-hotspot

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt update && \
    apt upgrade -y && \
    apt install -y openssl ca-certificates bash curl libtcnative-1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

ADD ./run.sh /app/
ADD ./csca_to_ks.sh /app/
ADD ./sslpoke-1.0.jar /app/
ADD https://repo1.maven.org/maven2/org/bouncycastle/bcprov-jdk15on/1.66/bcprov-jdk15on-1.66.jar /app/bcprov-jdk15on.jar

RUN addgroup --gid 1000 --system java && \
    adduser --uid 1000 --system java --gid 1000  && \
    mkdir -p /etc/keystore && \
    chown -R java:java /home/java /app /etc/keystore && \
    chmod +x /app/run.sh /app/csca_to_ks.sh
