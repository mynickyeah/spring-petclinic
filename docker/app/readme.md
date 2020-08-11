# Dockerfile for spring application container
#### For building this image, run next command:
```bash
docker build -t ${APP_TAG} ${REPO_URL}#${BUILD_BRANCH} -f ${APP_DF_PATH} 
```
Here ${APP_TAG} is your image tag for application container, ${REPO_URL} - link to github repository, which will be used as context, and ${APP_DF_PATH} specifies path, where your Dockerfile is.

#### For running this container, run next command:
```bash
docker run -p 8080:8080 ${APP_TAG}
```
Here you map port 8080 in the container to port 8080 on the Docker host, and by adding ${APP_TAG} you specify which container will be runnning.
