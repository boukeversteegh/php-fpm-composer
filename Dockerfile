FROM php:7.2.1-fpm

# Install git, composer dependencies
RUN apt-get update && apt-get install -y git-all zip unzip

# RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql

# Install composer
ADD https://github.com/composer/getcomposer.org/raw/master/web/installer composer-setup.php
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer && rm composer-setup.php

# Set composer vendor directory
ENV COMPOSER_VENDOR_DIR=/var/lib/composer/vendor
ENV COMPOSER_CACHE_DIR=/var/lib/composer/cache
RUN mkdir -p $COMPOSER_VENDOR_DIR -p $COMPOSER_CACHE_DIR

# Install prestissimo
RUN composer global require "hirak/prestissimo:^0.3" --prefer-dist

WORKDIR /var/www/html
