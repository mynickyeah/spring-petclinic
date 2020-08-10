FROM maven:3.5-jdk-8-alpine as build
COPY ./ /app
WORKDIR /app
RUN --mount=type=cache,target=/root/.m2 mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
USER ${APP_USER}
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]
