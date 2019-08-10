FROM gradle:5.5.1-jdk8 as compile
COPY . /home/source/java
WORKDIR /home/source/java
USER root
RUN chown -R gradle /home/source/java
USER gradle
RUN gradle clean assemble

FROM openjdk:8u222-jre-slim-buster
WORKDIR /home/application/java
COPY --from=compile "/home/source/java/build/libs/demo-0.0.1-SNAPSHOT.jar" .
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/home/application/java/demo-0.0.1-SNAPSHOT.jar"]
