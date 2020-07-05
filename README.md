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
