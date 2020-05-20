FROM existenz/webstack:7.4-codecasts

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php \
        php7-bcmath \
        php-curl \
        php-dom \
        php-exif \
        php-gd \
        php-iconv \
        php-intl \
        php-json \
        php-mbstring \
        php-pcntl \
        php-pdo_mysql \
        php-phar \
        php-posix \
        php-redis \
        php-session \
        php-xml \
        php-zip \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php7 /usr/bin/php

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www