FROM ghcr.io/graalvm/graalvm-ce:22.3.1 as base

RUN ${JAVA_HOME}/bin/gu install native-image

RUN microdnf -y install maven

WORKDIR /app
COPY . /app
RUN ls -la /app

RUN mvn -f /app/pom.xml install -Dnative
FROM alpine as scratch
COPY --from=base /app/target/code-with-quarkus-1.0.0-SNAPSHOT-runner .
ENTRYPOINT  ["code-with-quarkus-1.0.0-SNAPSHOT-runner"]
