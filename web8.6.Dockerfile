FROM existenz/webstack:8.6-edge

# PHP 8.6 is not in a stable Alpine release yet, so it is pulled from the edge testing repository
RUN apk -U --no-cache add \
        --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
        php86 \
        php86-bcmath \
        php86-curl \
        php86-dom \
        php86-exif \
        php86-gd \
        php86-iconv \
        php86-intl \
        php86-mbstring \
        php86-pcntl \
        php86-pdo_mysql \
        php86-pdo_pgsql \
        php86-phar \
        php86-posix \
        php86-pecl-redis \
        php86-session \
        php86-xml \
        php86-zip \
        php86-tokenizer \
        php86-fileinfo \
        php86-xmlwriter \
        php86-xmlreader \
        php86-simplexml \
    && rm -rf /var/cache/apk/* \
    && ln -sfn /usr/bin/php86 /usr/bin/php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
