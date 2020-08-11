# Dockerfile for mysql database container
#### For building this image, run next command:
```bash
docker build -t ${DB_TAG} ${REPO_URL}#${BUILD_BRANCH} -f ${DB_DF_PATH} 
```
Here ${DB_TAG} is your image tag for database container, ${REPO_URL} - link to github repository, which will be used as context, and ${DB_DF_PATH} specifies path, where your Dockerfile is.

#### For running this container, run next command:
```bash
docker run -p 3306:3306 ${DB_TAG}
```
Here you map port 3306 in the container to port 3306 on the Docker host, and by adding ${DB_TAG} you specify which container will be runnning.
