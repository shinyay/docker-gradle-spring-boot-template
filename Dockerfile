FROM gradle:6.5.1-jdk11 as java-build
WORKDIR /app/
COPY --chown=gradle:gradle . .
RUN gradle assemble --no-daemon
# Un-pack the uber-JAR
RUN mkdir -p build/libs/dependency && (cd build/libs/dependency; jar -xf ../*.jar)

FROM openjdk:11.0.7-jre-slim
ARG DEPENDENCY=/app/build/libs/dependency
COPY --from=java-build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=java-build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=java-build ${DEPENDENCY}/BOOT-INF/classes /app
# We now run Java with a classpath definition, instead of a link to a JAR
ENTRYPOINT ["java","-cp","app:app/lib/*","io.spring.shinyay.demo.DemoApplicationKt"]
