FROM maven:3.6.1-jdk-11-slim as build
COPY ./ /app
WORKDIR /app
RUN --mount=type=cache,target=/root/.m2 mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
ENV appUser = "appuser"
COPY --from=build /app/target/*.jar /app/app.jar
USER appUser
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]
