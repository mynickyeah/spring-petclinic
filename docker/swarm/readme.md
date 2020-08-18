# Using docker containerisation tool for setting up this project
## Separate Dockerfiles for application and database containers, with instructions on how to build them separately. Compose file for running application and database containers on host or deploying using docker machines and docker swarm. Make sure you have docker and docker-compose installed on your PC, if not, follow [this link](https://docs.docker.com/engine/install/) for guide on how to install docker, and for docker-compose [this link](https://docs.docker.com/compose/install/).
## **Running project locally**
### First of all you need to create .env script, add listed environment variables, make script executable and export variables.
```bash
touch .env
```

```bash
vi .env
```

export DOCKER_BUILDKIT=1\
export COMPOSE_DOCKER_CLI_BUILD=1\
export LOCAL_REGISTRY="localhost:5000"\
export REPO_URL="https://github.com/kerimovkhikmet/spring-petclinic.git"\
export BUILD_BRANCH="feature"\
export COMPOSE_PATH="spring-petclinic/docker/swarm/docker-compose.yaml"\
export STACK_NAME="spring-stack"\
export DB_DF_PATH="./docker/db/Dockerfile"\
export DB_USER="petclinic"\
export DB_PASS="petclinic"\
export DB_IMG_NAME="petclinic-db"\
export DB_TAG="v1.0"\
export DB_NAME="petclinic"\
export DB_PORT="3306"\
export APP_DF_PATH="./docker/app/Dockerfile"\
export APP_USER="appuser"\
export APP_IMG_NAME="petclinic-app"\
export APP_TAG="v1.0"

```bash
sudo chmod +x .env
```

```bash
source .env
```

#### After, clone remote repository, by running next command:
```bash
git clone -b "${BUILD_BRANCH}" "${REPO_URL}"
```

#### Now you should start your local registry and build images for application and database containers. After building each image push it to your registry.
```bash
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```

```bash
docker build -t "${LOCAL_REGISTRY}/${APP_IMG_NAME}:${APP_TAG}" "${REPO_URL}#${BUILD_BRANCH}" -f "${APP_DF_PATH}"
```

```bash
docker push "${LOCAL_REGISTRY}/${APP_IMG_NAME}:${APP_TAG}"
```

```bash
docker build -t "${LOCAL_REGISTRY}/${DB_IMG_NAME}:${DB_TAG}" "${REPO_URL}#${BUILD_BRANCH}" -f "${DB_DF_PATH}"
```

```bash
docker push "${LOCAL_REGISTRY}/${DB_IMG_NAME}:${DB_TAG}"
```

#### And finally for running this application, execute next command and open http://localhost:8080/ in your browser:
```bash
docker-compose -f "${COMPOSE_PATH}" up -d
```

## **Running project on docker-machines and deploying to docker swarm**
#### For this way of setting and running spring-petclinic app, you have to install [docker-machine](https://docs.docker.com/machine/install-machine/), and [virtualbox](https://www.virtualbox.org/wiki/Downloads) on your system. After that, you have to create two machines - manager and worker.
```bash
docker-machine create --driver virtualbox manager
```

#### By running this command, you will configure your shell.
```bash
eval $(docker-machine env manager)
```

#### This command will show the environment information for the manager.
```bash
docker-machine env manager
``` 

```bash
docker-machine create --driver virtualbox worker
```

```bash
eval $(docker-machine env worker)
```

#### Run next command to see information about created docker-machines.
```bash
docker-machine ls
```

#### By executing next command, you will ssh to manager machine.
```bash
docker-machine ssh manager
```

#### Run next command for initiating swarm, and use ip of manager machine, which you get from penultimate command: 
```bash
docker swarm init --advertise-addr "${MANAGER_IP}"
```

#### Copy command which was outputed, and then open new terminal, ssh to worker machine, and paste it, in order to add worker to swarm.
```bash
docker-machine ssh worker 
```

```bash
docker swarm join --token "${TOKEN_FROM_MANAGER}"
```

#### Create folder, for database persistance:
```bash
sudo mkdir /backupDB
```

#### For starting the registry as a service on your swarm, run the next command:
```bash
docker service create --name registry --publish published=5000,target=5000 registry:2
```

#### Check its status with:
```bash
docker service ls
```

#### Now go back to manager machine, and follow the same steps, as if you were running project locally, which includes setting up of .env file, cloning repo, building and pushing images to local registry, and instead of last command where you up everything with **docker-compose**, run the next command, for deploying to the stack:
```bash
docker stack deploy --with-registry-auth --compose-file "${COMPOSE_PATH}" "${STACK_NAME}"
```
#### And finally open http://"${MANAGER_IP}":8080/ in your browser, to see working application.