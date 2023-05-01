FROM alpine:3.16

# 必要なパッケージのインストール
# https://make.wordpress.org/hosting/handbook/server-environment/
RUN apk add --no-cache \
  php8 \
  php8-fpm \
  php8-mysqli \
  php8-opcache \
  php8-bcmath \
  php8-exif \
  php8-gd \
  php8-curl \
  php8-json \
  php8-mbstring \
  php8-intl \
  php8-xml \
  php8-zip \
  php8-openssl \
  php8-pear \
  php8-phar \
  php8-zip \
  php8-zlib \
  mariadb-client \
  curl \
  ca-certificates \
  tar \
  wget \
  bash \
  less

# WP-CLIのインストール
RUN apk add --no-cache \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && chmod +x /usr/local/bin/wp

# WordPressのインストール
RUN set -ex \
  && mkdir -p /var/www/html/wordpress \
  && chown -R nobody:nobody /var/www/html/wordpress

# WordPressの設定
COPY ./tools/startup.sh /startup.sh

# ディレクトリのパーミッション設定
RUN chmod -R 777 /var/www/html/wordpress
RUN chmod 777 /startup.sh

# PHP-FPMの設定
COPY ./conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

# コンテナ起動時にPHP-FPMを起動する
CMD ["/startup.sh"]
