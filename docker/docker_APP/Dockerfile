# syntax=docker/dockerfile:experimental
#---------------------------------------------------------------------------
# Dockefile to build Docker Image of application container for spring_APP running on Ubuntu
#---------------------------------------------------------------------------

# ======= BUILD APP ========
FROM openjdk:8-jdk-alpine as builder

WORKDIR /spring
# Copy SRC and build application
COPY . /spring
COPY docker/docker_APP/application-mysql.properties /spring/src/main/resources/application-mysql.properties
RUN --mount=type=cache,target=/root/.m2 /spring/mvnw -Dcheckstyle.skip package

# ======= START APP =========

FROM openjdk:8-jre-alpine
# RUN APP

COPY --from=builder /spring/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /app.jar
CMD  [ "java", "-jar", "-Dspring.profiles.active=mysql", "/app.jar"]
EXPOSE 8080

