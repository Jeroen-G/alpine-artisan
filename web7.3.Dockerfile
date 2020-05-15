# === Base stage ===
FROM existenz/webstack:7.3 as base

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php7 \
        php7-curl \
        php7-dom \
        php7-exif \
        php7-gd \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-pdo_mysql \
        php7-session

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# ===Prod stage ===
FROM base as prod

COPY --chown=php:nginx . /www

# Set vendor aside for performance
COPY --chown=php:nginx ./vendor /tmp/vendor

RUN chown -R php:nginx /www \
    && chmod -R 555 /www \
    && find /www -type f -exec chmod -R 444 {} \; \
    && find /www/storage /www/bootstrap/cache -type d -exec chmod -R 755 {} \; \
    && find /www/storage /www/bootstrap/cache -type f -exec chmod -R 644 {} \;

# Put vendor back
RUN mv /tmp/vendor /www/vendor

# === Dev stage ===
FROM prod AS dev

ARG USERID=1000
ARG GROUPID=1000

RUN apk -U add \
    shadow \
    php-phar \
    php7-pecl-xdebug \
    && usermod -u ${USERID} php \
    && groupmod -o -g ${GROUPID} php \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/cache/apk/*

COPY ./files/dev/xdebug.ini /etc/php7/conf.d/xdebug.ini
