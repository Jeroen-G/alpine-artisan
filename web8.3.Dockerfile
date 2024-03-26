FROM existenz/webstack:8.3

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php83 \
        php83-bcmath \
        php83-curl \
        php83-dom \
        php83-exif \
        php83-gd \
        php83-iconv \
        php83-intl \
        php83-mbstring \
        php83-pcntl \
        php83-pdo_mysql \
        php83-pdo_pgsql \
        php83-phar \
        php83-posix \
        php83-redis \
        php83-session \
        php83-xml \
        php83-zip \
        php83-tokenizer \
        php83-fileinfo \
        php83-xmlwriter \
        php83-xmlreader \
        php83-simplexml \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php83 /usr/bin/php

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
