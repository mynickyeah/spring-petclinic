# mysql base image
FROM mysql:5.7

# setting environment variables for mysql database
ENV MYSQL_ROOT_PASSWORD=${DB_PASS} 
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true 
ENV MYSQL_USER=${DB_USER}
ENV MYSQL_PASSWORD=${DB_PASS}
ENV MYSQL_DATABASE=${DB_NAME}