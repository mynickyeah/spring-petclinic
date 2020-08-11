# syntax=docker/dockerfile:experimental
#---------------------------------------------------------------------------
# Dockefile to build Docker Image of application container for spring_APP running on Ubuntu
#---------------------------------------------------------------------------

# ======= BUILDER ========
FROM openjdk:8-jdk-alpine as builder


WORKDIR /
# Copy SRC and build application
COPY . /
COPY docker/docker_APP/application-mysql.properties /src/main/resources/application-mysql.properties
RUN --mount=type=cache,target=/root/.m2 /mvnw -Dcheckstyle.skip package

# ======= START APP =========

FROM openjdk:8-jre-alpine
# RUN APP
USER app_user

COPY --from=builder /target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /app.jar
CMD  [ "java", "-jar", "-Dspring.profiles.active=mysql", "/app.jar"]
EXPOSE 8080

