FROM existenz/webstack:8.5

RUN apk -U --no-cache add \
        php85 \
        php85-bcmath \
        php85-curl \
        php85-dom \
        php85-exif \
        php85-gd \
        php85-iconv \
        php85-intl \
        php85-mbstring \
        php85-pcntl \
        php85-pdo_mysql \
        php85-pdo_pgsql \
        php85-phar \
        php85-posix \
        php85-redis \
        php85-session \
        php85-xml \
        php85-zip \
        php85-tokenizer \
        php85-fileinfo \
        php85-xmlwriter \
        php85-xmlreader \
        php85-simplexml \
    && rm -rf /var/cache/apk/* \
    && ln -sfn /usr/bin/php85 /usr/bin/php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
