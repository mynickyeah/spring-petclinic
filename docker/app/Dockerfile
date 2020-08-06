FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/kerimovkhikmet/spring-petclinic.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/spring-petclinic /app
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]