FROM alpine:3.16

# 必要なパッケージのインストール
RUN apk add --no-cache \
        php8 \
        php8-fpm \
        php8-mysqli \
        php8-opcache \
        php8-gd \
        php8-curl \
        php8-json \
        php8-mbstring \
        php8-intl \
        php8-xml \
        php8-zip \
        curl \
        ca-certificates \
        tar \
        wget \
        bash

# userの作成
RUN addgroup -S administrator \
    && adduser -S syamashi -G administrator \
    && adduser -S user

# WP-CLIのインストール
RUN apk add --no-cache \
        bash \
        less \
        mysql-client \
        php8-openssl \
        php8-phar \
        php8-zlib \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# WordPressのインストール
ENV WORDPRESS_VERSION 6.2
RUN set -ex \
    && mkdir -p /var/www/html/wordpress \
    && wp core download --version="${WORDPRESS_VERSION}" --locale=ja --allow-root --path=/var/www/html/wordpress\
    && chown -R nobody:nobody /var/www/html/wordpress

# WordPressの設定
COPY ./conf/wp-config.php /var/www/html/wordpress

# ディレクトリのパーミッション設定
RUN chmod -R 777 /var/www/html/wordpress

# PHP-FPMの設定
COPY ./conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

# コンテナ起動時にPHP-FPMを起動する
CMD ["php-fpm8", "-F"]
