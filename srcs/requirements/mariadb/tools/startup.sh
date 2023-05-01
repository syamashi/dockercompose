#!/bin/sh

# -d = is directory?
if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
# MySQLサーバーの初期化
echo "[i] mysql_install_db --datadir=/var/lib/mysql --user=root > /dev/null"
mysql_install_db --datadir=/var/lib/mysql --user=root > /dev/null
chmod 777 -R /var/lib/mysql

# mktemp make a random name file
# /tmp/tmp.LCOCdE
tfile=`mktemp`
# -f = is normal file?
if [ ! -f "$tfile" ]; then
  return 1
fi

cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
EOF

if [ "$WORDPRESS_DB_NAME" != "" ]; then
  echo "[i] Creating database DB_NAME:$WORDPRESS_DB_NAME"
  # COLLATE = set sort database rule
  echo "CREATE DATABASE IF NOT EXISTS \`$WORDPRESS_DB_NAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

  if [ "$WORDPRESS_DB_USER" != "" ]; then
    echo "[i] Creating DB_USER:$WORDPRESS_DB_USER DB_PASSWORD:$WORDPRESS_DB_PASSWORD"
    # %:wildcatd host
    echo "GRANT ALL ON \`$WORDPRESS_DB_NAME\`.* to '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';" >> $tfile
  fi
fi

# verbose=0: logを出さない
/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 < $tfile
rm -f $tfile

echo " => mariadb startup.sh is Done!"

exec /usr/bin/mysqld --user=mysql --console
