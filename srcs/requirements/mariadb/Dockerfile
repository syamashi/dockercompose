FROM alpine:3.16

RUN apk add --no-cache mariadb mariadb-client

# Copy the custom configuration file for mariadb
COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./tools/init.sql /init.sql

# Set permissions for mariadb data directory
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql

# Copy the entrypoint script to the container
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

# Set the entrypoint to the custom script
ENTRYPOINT ["/entrypoint.sh"]

# Start the mariadb service
CMD ["mysqld", "--user=mysql", "--console"]