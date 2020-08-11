================== RUN CONTAINER =====================

 **** By default MYSQL_USER=$DB_USER, MYSQL_DATABASE=$DB_NAME

docker run \
-e MYSQL_PASSWORD=$DB_PASS \
-e MYSQL_ROOT_PASSWORD=$DB_ROOT_PASS \
-v vol_for_db:/var/lib/mysql/ \
--name DB_CONT \
--network my-net \
--ip $IP_DB \
-d petclinic-db:1.1


