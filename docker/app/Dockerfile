# syntax=docker/dockerfile:experimental
# base build image
FROM maven:3.5-jdk-8-alpine as build

# # copy the project files
# COPY ./pom.xml ./pom.xml

# # build all dependencies
# RUN mvn dependency:go-offline -B

# copying other files
COPY ./ /app

# setting working directory
WORKDIR /app

# # building package and running tests
# RUN mvn package

RUN --mount=type=cache,target=/root/.m2 mvn -X -Dcheckstyle.skip package





# final base image
FROM openjdk:8-jre-alpine

# setting working directory
WORKDIR /app

# copying jar file into new folder, and setting it's name
COPY --from=build /app/target/*.jar /app/app.jar

# setting the username
USER ${APP_USER}

# directive for proper execution of a file
ENTRYPOINT ["sh", "-c"]

# set the startup command to run binary
CMD ["java -jar app.jar --spring.profiles.active=mysql"]
