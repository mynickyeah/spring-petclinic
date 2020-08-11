# base build image
FROM maven:3.5-jdk-8-alpine as build

# copy the project files
COPY ./pom.xml ./pom.xml

# build all dependencies
RUN mvn dependency:go-offline -B

# copying other files
COPY ./ /app

# setting working directory
WORKDIR /app

# building package and running tests
RUN mvn package




# final base image
FROM openjdk:8-jre-alpine

# setting working directory
WORKDIR /app

# setting environment variable to value for application user
ENV appUser ${APP_USER}

# copying jar file into new folder, and setting it's name
COPY --from=build /app/target/*.jar /app/app.jar

# setting the username
USER appUser

# exposing port 8080
EXPOSE 8080

# directive for proper execution of a file
ENTRYPOINT ["sh", "-c"]

# set the startup command to run binary
CMD ["java -jar app.jar --spring.profiles.active=mysql"]
