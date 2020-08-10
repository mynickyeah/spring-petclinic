# syntax=docker/dockerfile:experimental
FROM maven:3.6.1-jdk-11-slim as build
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY ./ /app
WORKDIR /app
RUN mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
ENV appUser ${APP_USER}
COPY --from=build /app/target/*.jar /app/app.jar
USER appUser
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar --spring.profiles.active=mysql"]
