FROM maven:3.5-jdk-8-alpine as build
RUN cd ../../ && echo $(pwd)
WORKDIR /app
COPY . /app
RUN mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]