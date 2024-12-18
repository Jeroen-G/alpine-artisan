FROM existenz/webstack:8.4

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php84 \
        php84-bcmath \
        php84-curl \
        php84-dom \
        php84-exif \
        php84-gd \
        php84-iconv \
        php84-intl \
        php84-mbstring \
        php84-pcntl \
        php84-pdo_mysql \
        php84-pdo_pgsql \
        php84-phar \
        php84-posix \
        php84-redis \
        php84-session \
        php84-xml \
        php84-zip \
        php84-tokenizer \
        php84-fileinfo \
        php84-xmlwriter \
        php84-xmlreader \
        php84-simplexml \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php83 /usr/bin/php

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
