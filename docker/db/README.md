re required files for setting up Docker container with MySQL DB for Spring-Petlinic app. It is based on [lindycoder](https://github.com/lindycoder/prepopulated-mysql-container-example)'s implementation of prepopulated container. Here, `setup.sql` is a file that is used for setting a db on startup, and it uses `setup.sh` to set DB settings from env values. Build: 
```bash
docker build . -t petclinic-db:latest --build-arg MYSQL_USER=$MYSQL_USER --build-arg MYSQL_NAME=$MYSQL_DATABASE --build-arg MYSQL_ROOT_PASS=$MYSQL_ROOT_PASSWORD --build-arg MYSQL_PASS=$MYSQL_PASS
```
Run:
```bash
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --name petclinic-db --network petclinic --ip $MYSQL_IP -v db:/var/lib/mysql petclinic-db
```
