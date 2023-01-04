
FROM tomcat:9.0.70-jre8-temurin-jammy
WORKDIR /toxi
COPY /target .
# ENTRYPOINT java -jar toxictypoapp-1.0-SNAPSHOT.jar
ENTRYPOINT bash


