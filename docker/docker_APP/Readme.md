====================== BUILD ===========================

DOCKER_BUILDKIT=1 docker build  -t name:tag -f docker/docker_APP/Dockerfile https://github.com/OlehAvramenko/spring-petclinic.git#$build_branch

============== BUILD RESERVE DOCKERFILE ================

docker build -t name:tag --build-arg URL=https://github.com/OlehAvramenko/spring-petclinic.git . 

================== RUN CONTAINER =======================

docker run -d -p 8080:8080 \
-e DB_HOST=$IP_DB \
-e DB_PORT=$DB_PORT \
-e DB_NAME=$MYSQL_DATABASE \
-e DB_USER=$MYSQL_USER \
-e DB_PASS=$DB_PASS \
--name APP_CONT \
--network my-net \
petclinc-app:latest
