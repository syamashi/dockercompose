#!/bin/sh

# / # wp user create
# Error: This does not seem to be a WordPress installation.
# Pass --path=`path/to/wordpress` or run `wp core download`.

# wordpressのpathを要求される
cd /var/www/html/wordpress/

# /var/www/html/wordpress # wp user create
# Error: The site you have requested is not installed.
# Run `wp core install` to create database tables.

# databaseが立つまで待機
while ! mariadb -h$MYSQL_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME --silent; do
	echo "[INFO] waiting for database..."
	sleep 5;
done

# https://qiita.com/IK12_info/items/4a9190119be2a0f347a0
echo "[i] wordpress downloading..."
wp core download --version=$WORDPRESS_VERSION --locale=ja --allow-root
echo "[i] wordpress config setting..."
# wp-config.phpのセットアップ
wp core config --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$MYSQL_HOST --allow-root
echo "[i] wordpress installing..."
# database tablesがないのでwp core installを実施
wp core install --allow-root \
	--url=$WORDPRESS_URL \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_ADMIN_MAIL

# --role 購読者 subscriber / 寄稿者 contributor / 投稿者 author / 編集者 editor / 管理者 administrator
# https://analyzegear.co.jp/blog/356#toc2
wp user create --allow-root \
	user01 \
	user01@42tokyo.jp \
	--role=subscriber \
	--user_pass=user01

wp user create --allow-root \
	user02 \
	user02@42tokyo.jp \
	--role=contributor \
	--user_pass=user02

wp user create --allow-root \
	user03 \
	user03@42tokyo.jp \
	--role=author \
	--user_pass=user03

wp user create --allow-root \
	user04 \
	user04@42tokyo.jp \
	--role=editor \
	--user_pass=user04

echo "wordpress start"

php-fpm8 -F -R