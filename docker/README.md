# Docker

To deploy application to docker, docker volume `db` should be created:
```bash
docker volume create db
```
Docker network is also required, eg:
```bash
docker network create --driver bridge --subnet 172.28.0.0/16 --ip-range 172.28.5.0/24 --gateway 172.28.5.254 petclinic
```
