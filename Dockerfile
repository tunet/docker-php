ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm-alpine3.18

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
    && docker-php-ext-enable apcu \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install intl \
    && pecl clear-cache \
    && rm -rf /tmp/* /var/cache/apk/* \
    && apk del .build-deps

COPY ./php.ini /usr/local/etc/php/php.ini

WORKDIR /srv/app
