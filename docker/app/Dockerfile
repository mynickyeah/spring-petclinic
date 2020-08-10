# syntax=docker/dockerfile:experimental
FROM maven:3.6.1-jdk-11-slim as build
COPY ./ /app
WORKDIR /app
COPY pom.xml /tmp/pom.xml
RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
RUN mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
ENV appUser ${APP_USER}
COPY --from=build /app/target/*.jar /app/app.jar
USER appUser
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar --spring.profiles.active=mysql"]
