FROM php:8.4-fpm

COPY script.sh /usr/bin/script
RUN chmod +x /usr/bin/script

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libssl-dev \
        zlib1g-dev \
        curl \
        git \
        unzip \
        netcat-traditional \
        libxml2-dev \
        libpq-dev \
        libzip-dev \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libwebp-dev && \
    pecl install apcu && \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install -j$(nproc) zip opcache intl pdo_pgsql pgsql bcmath && \
    docker-php-ext-enable apcu pdo_pgsql sodium && \
    docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype && \
    docker-php-ext-install gd && \
    docker-php-ext-enable gd && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configure safe git directory
RUN git config --global --add safe.directory /var/www

ARG DOCKER_PHP_ENABLE_XDEBUG='off'

# Enable Xdebug (updated for Xdebug 3.x)
RUN if [ "${DOCKER_PHP_ENABLE_XDEBUG}" = "on" ]; then \
    pecl install xdebug && \
    docker-php-ext-enable xdebug; \
    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.start_with_request=trigger" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    php -m; \
    else \
    echo "Skip xdebug support"; \
    fi

COPY php.ini /usr/local/etc/php

WORKDIR /var/www

EXPOSE 9000
