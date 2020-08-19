## Running petclinic application with docker compose

### Steps:

1) Add an enviromental variables to your host system: 

	*BUILD_BRANCH=build_branch*
        
	*DOCKER_BUILDKIT=1*

2) Clone the project and checkout to *$BUILD_BRANCH*:

	```git clone https://github.com/anika-is-here/spring-petclinic```
        
        ```git checkout $BUILD_BRANCH```

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
        
## Running petclinic application in swarm mode

### Steps:

0) Repeat 1-4 steps described in the first part for machine that will be a manager of swarm cluster. Add port forwarding for ports 5000 at manager and 3306 at worker nodes.

1) Assign your machine a manager using:

        ```docker swarm init --advertise-addr $manager_IP```
        
        Use the output to join worker nodes. Don't forget to add *$manager_IP* as an environmental variable.
        
 2) Create a network between nodes:
 
        ```docker network create -d overlay mynetwork```
        
 3) Set up insecure docker registry. Add/edit at your worker nodes file */var/lib/docker/daemon.json* with string:
 
        ```{"insecure-registries" : ["$manager_IP:5000"]}```
        
        Restart docker and daemon services:
        
        ```sudo systemctl daemon-reload```
        
        ```sudo systemctl restart docker```
        
 4) Deploy stack:)
 
        ```docker stack deploy -c ./docker/swarm/docker-compose.yml $my_stack_name```
        
 P.S. useful for checking: ```docker stack ps --no-trunc $my_stack_name```
