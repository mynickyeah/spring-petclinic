# Dockerfile for spring application container
#### For pushing images, start local registry:
```bash
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

#### For building this image, run next command:
```bash
docker build -t "${LOCAL_REGISTRY}/${APP_IMG_NAME}:${APP_TAG}" "${REPO_URL}#${BUILD_BRANCH}" -f "${APP_DF_PATH}"
```

#### For pushing this image, run next command:
```bash
docker push "${LOCAL_REGISTRY}/${APP_IMG_NAME}:${APP_TAG}"
```

Information about setting environment variables, [provided here](https://github.com/kerimovkhikmet/spring-petclinic/blob/feature/docker/readme.md).
