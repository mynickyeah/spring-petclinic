FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY /spring-petclinic /app
RUN mvn package

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
RUN useradd -m ${APP_USER} && echo -e "${APP_PASS}\n${APP_PASS}\n" | sudo passwd ${APP_USER}
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]
#CMD ["-E -u ${APP_USER} java -jar ${APP_DIR}/app.jar"]
