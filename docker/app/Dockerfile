# syntax=docker/dockerfile:experimental

FROM openjdk:12-ea-25-alpine3.8 AS BUILD
ARG BUILD_BRANCH
#download binutils for stripping java library
RUN apk add --no-cache git binutils

RUN cd /root/; \
   git clone -b $BUILD_BRANCH https://github.com/CesarionPshebytski/spring-petclinic.git app/

WORKDIR /root/app
#mount .m2 folder from host to docker build to get dependencies
#packaging application using 2 threads per core
#creating custom jre with only required dependencies
#spripping inessential information from jvm library
RUN --mount=type=bind,source=./.m2,target=/root/.m2,rw ./mvnw -T 2C package; \
    jlink --output /java-runtime --no-header-files --no-man-pages --compress=2 --strip-debug --add-modules java.desktop,java.instrument,jdk.crypto.cryptoki,jdk.management,java.sql,jdk.security.auth,jdk.unsupported; \
    strip -p --strip-unneeded /java-runtime/lib/server/libjvm.so



FROM alpine:latest 
#copying jre from build stage
COPY --from=BUILD /java-runtime /java-runtime
ENV PATH="/java-runtime/bin:${PATH}"
#new user to launch application
RUN addgroup -S petclinic && adduser -S petclinic -G petclinic
USER petclinic:petclinic
ENV spring_profiles_active=mysql

COPY --from=BUILD /root/app/target/*.jar /app.jar

EXPOSE 8080

CMD ["java", "-jar", "/app.jar"]
