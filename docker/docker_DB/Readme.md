# RUN CONTAINER
# **** By default MYSQL_USER=petclinic, MYSQL_DATABASE=petclinic
docker run \
-e MYSQL_PASSWORD=$DB_PASS \
-e MYSQL_ROOT_PASSWORD=$DB_ROOT_PASS \
-v vol_for_db:/var/lib/mysql/ \
--name DB_CONT \
--network my-net \
--ip $IP_DB \
-d petclinic-db:1.1


