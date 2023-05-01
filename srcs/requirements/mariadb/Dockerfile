FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client;

# Copy the custom configuration file for mariadb
# 1. /etc/my.cnf
# 2. /etc/mysql/my.cnf
# 3. /etc/my.cnf.d/*.cnf
# 4. $MYSQL_HOME/my.cnf
COPY ./conf/my.cnf /etc/my.cnf

# Set permissions for mariadb data directory
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql

# Copy the entrypoint script to the container
COPY ./tools/startup.sh /tmp/startup.sh
RUN chmod -R 755 /tmp

EXPOSE 3306

# Set the entrypoint to the custom script
ENTRYPOINT ["/tmp/startup.sh"]