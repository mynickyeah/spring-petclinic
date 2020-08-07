#---------------------------------------------------------------------------
# Dockefile to build Docker Image of application container for spring_APP running on Ubuntu
#---------------------------------------------------------------------------

# ======== CLONE SRC ==========
FROM alpine/git:v2.26.2 as git

# Setting vars
# Define URL via --build-arg
ENV PROJECT_DIR /springapp/spring-petclinic
ARG URL 

# Clone repo
RUN mkdir /springapp && \
cd /springapp && \
git clone $URL

# ========= BUILDER ========

FROM openjdk:8-jdk-alpine as builder
# COPY src and .m2
ENV PROJECT_DIR /springapp/spring-petclinic
RUN mkdir ~/.m2 
COPY .m2  /root/.m2
# RUN --mount=type=bind,source=/home/vagrant/.m2,target=/root/.m2,rw 
COPY --from=git /springapp /springapp

# Build application
COPY application-mysql.properties $PROJECT_DIR/src/main/resources/application-mysql.properties
RUN cd $PROJECT_DIR && \
 ./mvnw clean package

# ======= START APP =========

FROM openjdk:8-jre-alpine

# RUN APP
COPY --from=builder /springapp/spring-petclinic/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /app.jar
CMD  [ "java", "-jar", "-Dspring.profiles.active=mysql", "/app.jar"]
EXPOSE 8080

