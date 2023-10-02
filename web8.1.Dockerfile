FROM existenz/webstack:8.1

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php8 \
        php8-bcmath \
        php8-curl \
        php8-dom \
        php8-exif \
        php8-gd \
        php8-iconv \
        php8-intl \
        php8-mbstring \
        php8-pcntl \
        php8-pdo_mysql \
        php8-phar \
        php8-posix \
        php8-redis \
        php8-session \
        php8-xml \
        php8-zip \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php8 /usr/bin/php

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
