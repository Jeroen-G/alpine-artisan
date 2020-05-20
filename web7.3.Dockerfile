FROM existenz/webstack:7.3

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php7 \
        php7-curl \
        php7-dom \
        php7-exif \
        php7-fileinfo \
        php7-gd \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-pcntl \
        php7-pdo_mysql \
        php7-phar \
        php7-posix \
        php7-redis \
        php7-session \
        php7-tokenizer \
        php7-zip \
    && rm -rf /var/cache/apk/*

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www