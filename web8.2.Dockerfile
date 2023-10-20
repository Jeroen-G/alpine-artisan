FROM existenz/webstack:8.2

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv; \
    apk -U --no-cache add \
        php82 \
        php82-bcmath \
        php82-curl \
        php82-dom \
        php82-exif \
        php82-gd \
        php82-iconv \
        php82-intl \
        php82-mbstring \
        php82-pcntl \
        php82-pdo_mysql \
        php82-phar \
        php82-posix \
        php82-redis \
        php82-session \
        php82-xml \
        php82-zip \
        php82-tokenizer \
        php82-fileinfo \
        php82-xmlwriter \
        php82-simplexml \
        php82-ext-xmlreader \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php82 /usr/bin/php

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www
