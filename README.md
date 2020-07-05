# Dockerfile template for Spring Boot

Optimized Dockerfile template for Spring Boot to be reduced size and secured.

## Description

### Multi-stage Docker build

```
FROM gradle:6.5.1-jdk11 as java-build
  :
RUN gradle assemble
FROM gcr.io/distroless/java:11
  :
COPY --from=java-build
  :
ENTRYPOINT [ "java", ...]
```

### Clean separation between Dependencies and Application resources

Most frequently changing resources, usually the **class** and **static resources** in the application itself, to be layered after the more slowly changing resources

```
COPY --from=java-build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=java-build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=java-build ${DEPENDENCY}/BOOT-INF/classes /app
```

### UseContainerSupport

JVM will automatically detect the Control Group memory limit with the **UseContainerSupport** option.

```console
$ docker run -m 1GB openjdk:11.0.7-jre-slim java \
            -XX:+PrintFlagsFinal -version \
            | grep -E "UseContainerSupport | InitialRAMPercentage | MaxRAMPercentage | MinRAMPercentage"
WARNING: Your kernel does not support swap limit capabilities or the cgroup is not mounted. Memory limited without swap.
   double InitialRAMPercentage                     = 1.562500                                  {product} {default}
   double MaxRAMPercentage                         = 25.000000                                 {product} {default}
   double MinRAMPercentage                         = 50.000000                                 {product} {default}
     bool UseContainerSupport                      = true                                      {product} {default}
openjdk version "11.0.7" 2020-04-14
OpenJDK Runtime Environment 18.9 (build 11.0.7+10)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.7+10, mixed mode)
```
## Demo

## Features

- feature:1
- feature:2

## Requirement

## Usage

## Installation

## Licence

Released under the [MIT license](https://gist.githubusercontent.com/shinyay/56e54ee4c0e22db8211e05e70a63247e/raw/34c6fdd50d54aa8e23560c296424aeb61599aa71/LICENSE)

## Author

[shinyay](https://github.com/shinyay)
