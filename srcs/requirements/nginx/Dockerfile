FROM alpine:3.16

# update packages
RUN apk update && apk upgrade

# install nginx and openssl
RUN apk add --no-cache nginx openssl

# generate a self-signed SSL certificate
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/ssl/ft_inception.crt \
    -keyout /etc/ssl/ft_inception.key \
    -subj "/C=JP/ST=Tokyo/L=hoge/O=fuga/OU=foo/CN=localhost"

# copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# set permissions for nginx user
RUN adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www

# expose ports
EXPOSE 443

# set entry point
ENTRYPOINT ["nginx", "-g", "daemon off;"]