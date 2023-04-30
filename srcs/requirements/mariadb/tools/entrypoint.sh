#!/bin/sh

# MySQLをバックグラウンドで起動する
mysqld --user=mysql &

# MySQLが利用可能になるまで待機する
while ! mysqladmin ping -h localhost --silent; do
sleep 1
echo "waiting for mysqld to be connectable..."
done

mysql < /init.sql

# MySQLを通常モードで起動する
exec mysqld --user=mysql --console