#---------------------------------------------------------------------------
# Dockefile to build Docker Image of application container for spring_APP running on Ubuntu
#---------------------------------------------------------------------------
# Define PASS via --build-arg PASS=yourpass

FROM alpine/git:v2.26.2 as git

# Setting vars
ENV PROJECT_DIR /springapp/spring-petclinic
ARG URL 
# Install Git

# Clone repo
RUN mkdir /springapp && \
cd /springapp && \
git clone $URL

# BUILDER

FROM openjdk:8-jdk-alpine as builder
# COPY src and .m2
ENV PROJECT_DIR /springapp/spring-petclinic
RUN mkdir ~/.m2 
COPY .m2  /root/.m2
COPY --from=git /springapp /springapp

# Build application
COPY application-mysql.properties $PROJECT_DIR/src/main/resources/application-mysql.properties
RUN cd $PROJECT_DIR && \
 ./mvnw clean package

# For start APP

FROM openjdk:8-jre-alpine
# SET ENV
# ENV APP_USER appuser
# Define PASS via --build-arg PASS=yourpass 
# ARG PASS
# RUN useradd -m -p $PASS $APP_USER
# USER $APP_USER

# RUN APP
COPY --from=builder /springapp/spring-petclinic/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /app.jar
CMD  [ "java", "-jar", "-Dspring.profiles.active=mysql", "/app.jar"]
EXPOSE 8080

