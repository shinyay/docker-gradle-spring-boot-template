FROM gradle:6.0.1-jdk11 as compile
COPY . /home/source/java
WORKDIR /home/source/java
USER root
RUN chown -R gradle /home/source/java
USER gradle
RUN gradle clean assemble

FROM openjdk:11.0.4-jre-slim-buster
WORKDIR /home/application/java
COPY --from=compile "/home/source/java/build/libs/demo.jar" .
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/home/application/java/demo.jar"]
