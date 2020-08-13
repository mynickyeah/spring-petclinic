# Docker-application

Here you can find a Dockerfile for Spring-Petclinic application. To build, use command 
```bash
DOCKER_BUILDKIT=1 docker build . --build-arg BUILD_BRANCH=$BUILD_BRANCH --tag petclinic-app:latest
```
This requiers Docker experimental features to be enabled. `$BUILD_BRANCH` is and env identifying which exacly branch you want to build. This produces Alpine-based image containing `app.jar` and minimal JRE needed for running an application.
Run command: 
```bash
docker run -d -p 8080:8080 -e MYSQL_USER=$MYSQL_USER -e MYSQL_PASS=$MYSQL_PASS -e MYSQL_URL=jdbc:mysql://$MYSQL_IP/$MYSQL_DATABASE --network petclinic --ip $APP_IP petclinic-app
```
`$MYSQL_USER`, `$MYSQL_PASS`, `$MYSQL_IP`, `$MYSQL_DATABASE`, `$APP_IP` should be set on host machine.
Requires also for `.m2` directory to be present on host machine in current directory.
