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
ENV WORDPRESS_VERSION 5.8.3
# RUN set -ex \
#     && mkdir -p /usr/src/wordpress \
#     && cd /usr/src \
#     && wp core download --version="${WORDPRESS_VERSION}" --locale=ja \
#     && chown -R nobody:nobody /usr/src/wordpress
# 
# # WordPressの設定
# COPY ./conf/wp-config.php /usr/src/wordpress/
# 
# # ディレクトリのパーミッション設定
# RUN chown -R nobody:nobody /usr/src/wordpress \
#     && chmod -R 777 /usr/src/wordpress/wp-content
# 
# # PHP-FPMの設定
# COPY ./conf/php-fpm.conf /etc/php8/php-fpm.conf
# COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf
# 
# # コンテナ起動時にPHP-FPMを起動する
# CMD ["php-fpm8", "-F"]