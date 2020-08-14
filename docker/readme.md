## Running petclinic application with docker compose

### Steps:

1) Add an enviromental variables to your host system: 

	*BUILD_BRANCH=build_branch
	DOCKER_BUILDKIT=1*

2) Clone the project:

	```git clone https://github.com/anika-is-here/spring-petclinic -build $BUILD_BRANCH```

3) Change directory to project directory:

	```cd spring-petclinic```

3) Build the application and database images: 

	```docker build ./ -t petclinic-app -f docker/Dockerfile_app```
	```docker build ./ -t petclinic-db -f docker/Dockerfile_db```

4) Create a local docker registry and push images there:

	```docker run -d -p 5000:5000 --restart=always --name registry registry:2```

	```docker tag petclinic-app localhost:5000/my-petclinic-app```

	```docker tag petclinic-db localhost:5000/my-petclinic-db```

	```docker push localhost:5000/my-petclinic-app```
	
	```docker push localhost:5000/my-petclinic-db```

5) Up containers using docker-compose file:

	```docker-compose -f ./docker/docker-compose.yml up```