#!/bin/sh

sed -i 's/$MYSQL_DATABASE/'"$MYSQL_DATABASE"'/g' /docker-entrypoint-initdb.d/setup.sql
sed -i 's/$MYSQL_USER/'"$MYSQL_USER"'/g' /docker-entrypoint-initdb.d/setup.sql
sed -i 's/$MYSQL_PASS/'"$MYSQL_PASS"'/g' /docker-entrypoint-initdb.d/setup.sql
