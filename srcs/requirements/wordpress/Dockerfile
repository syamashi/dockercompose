FROM alpine:3.16.5

# update packages
RUN apk update && apk upgrade

# install required packages for WordPress
RUN apk add --no-cache \
    wget \
    tar \
    mariadb-client \
    php8 \
    php8-fpm \
    php8-bcmath \
    php8-exif \
    php8-gd \
    php8-intl \
    php8-mysqli \
    php8-pear \
    php8-phar \
    php8-zip

# cleanup
RUN rm -rf /var/cache/apk/*

# set work directory
WORKDIR /var/www/html

# download and extract WordPress
RUN wget -qO- https://wordpress.org/latest.tar.gz | tar zxvf -

# set permissions
RUN chown -R nobody:nobody /var/www/html/wordpress && \
    chmod -R 755 /var/www/html/wordpress

# copy custom configuration
COPY wp-config.php /var/www/html/wordpress/

# expose ports
EXPOSE 9000

# set entry point
ENTRYPOINT ["php-fpm8", "-F"]