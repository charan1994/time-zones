FROM java:8-jdk
RUN apt-get update && apt-get install -y curl
EXPOSE 8080/tcp 8081/tcp
RUN mkdir -p /opt/myapp
COPY ./target/TimeZones-0.0.1-SNAPSHOT.jar /opt/myapp/TimeZones.jar
ENTRYPOINT java -jar /opt/myapp/TimeZones.jar server /opt/myapp/yml/time.yml
