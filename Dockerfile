ARG PHP_VERSION

FROM php:${PHP_VERSION}

RUN apk update \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        postgresql-dev \
    && apk add --no-cache \
        icu-dev \
        make \
        postgresql-libs \
        postgresql-client \
    && docker-php-ext-install opcache \
    && pecl update-channels \
    && pecl install \
        apcu \
        redis \
    && docker-php-ext-enable apcu \
    && docker-php-ext-enable redis \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install intl \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-install pcntl \
    && pecl clear-cache \
    && rm -rf /tmp/* /var/cache/apk/* \
    && apk del .build-deps

COPY ./php.ini /usr/local/etc/php/php.ini

WORKDIR /srv/app
