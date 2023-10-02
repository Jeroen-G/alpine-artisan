FROM existenz/webstack:8.1

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php81 \
        php81-bcmath \
        php81-curl \
        php81-dom \
        php81-exif \
        php81-gd \
        php81-iconv \
        php81-intl \
        php81-mbstring \
        php81-pcntl \
        php81-pdo_mysql \
        php81-phar \
        php81-posix \
        php81-redis \
        php81-session \
        php81-xml \
        php81-zip \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php81 /usr/bin/php

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
