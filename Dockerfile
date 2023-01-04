FROM maven:3.3-jdk-8
WORKDIR /toxi
COPY . .
VOLUME /toxi
ENTRYPOINT bash 

