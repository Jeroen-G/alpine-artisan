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
        php7-redis \
        php7-session \
        php7-tokenizer \
        php7-zip \
    && rm -rf /var/cache/apk/*

# See https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ONBUILD COPY --chown=php:nginx . /www

# Set vendor aside for performance
# ONBUILD COPY --chown=php:nginx ./vendor /tmp/vendor

# ONBUILD RUN chown -R php:nginx /www \
#     && chmod -R 555 /www \
#     && find /www -type f -exec chmod -R 444 {} \; \
#     && find /www/storage /www/bootstrap/cache -type d -exec chmod -R 755 {} \; \
#     && find /www/storage /www/bootstrap/cache -type f -exec chmod -R 644 {} \;

# # Put vendor back
# ONBUILD RUN mv /tmp/vendor /www/vendor