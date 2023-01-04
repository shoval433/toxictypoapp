# FROM maven:3.3-jdk-8
FROM tomcat:9.0.70-jre8-temurin-jammy
WORKDIR /toxi
COPY . .
VOLUME /toxi
ENV VER-SNAP=1.0
ENTRYPOINT java -jar toxictypoapp-1.0-SNAPSHOT.jar


