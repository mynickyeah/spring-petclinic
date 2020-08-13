## Running petclinic application with docker compose

### Steps:

1) Add an enviromental variables to your host system: 

	*BUILD_BRANCH=build_branch
	DOCKER_BUILDKIT=1*

2) Clone the project:

```git clone https://github.com/anika-is-here/spring-petclinic -build $BUILD_BRANCH```

3) Change directory to project directory:

```cd spring-petclinic```

3) Build the application image: 

```docker build ./ -t petclinic-app -f docker/Dockerfile_app```

4) Up containers using docker-compose file:

```docker-compose -f ./docker/docker-compose.yml up```