#---------------------------------------------------------------------------
# Dockefile to build Docker Image of application container for spring_APP running on Ubuntu
#---------------------------------------------------------------------------
# Define PASS via --build-arg PASS=yourpass

FROM openjdk:11-jdk

# Setting vars
ENV PROJECT_DIR /springapp/spring-petclinic
ENV BUILD_BRANCH buildbr

# Install Git
RUN apt -y update && \
apt -y install git

# Clone repo
RUN mkdir springapp && \
cd /springapp && \
git clone https://github.com/mynickyeah/spring-petclinic.git

# Copy .m2 dir
RUN mkdir ~/.m2 
COPY .m2  /root/.m2

# Build application
COPY application-mysql.properties $PROJECT_DIR/src/main/resources/application-mysql.properties
RUN cd $PROJECT_DIR && \
git checkout -b $BUILD_BRANCH && \
 ./mvnw clean package

# For start APP

FROM openjdk:11-jdk
# SET ENV
ENV APP_USER appuser
# Define PASS via --build-arg PASS=yourpass 
ARG PASS
# Create USER
RUN useradd -m -p $PASS $APP_USER
# Run APP
USER $APP_USER
COPY --from=0 /springapp/spring-petclinic/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /app.jar
CMD  [ "java", "-jar", "-Dspring.profiles.active=mysql", "/app.jar"]
EXPOSE 8080

