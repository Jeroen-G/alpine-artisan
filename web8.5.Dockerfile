FROM existenz/webstack:8.5-edge

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
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
    && ln -s /usr/bin/php85 /usr/bin/php

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
