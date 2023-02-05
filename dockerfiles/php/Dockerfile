FROM php:8.1-fpm-alpine

ARG APP_ENV

COPY ./php.ini-* /usr/local/etc/php

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions gmp pdo_mysql curl imap ldap soap gd imap mailparse sourceguardian

RUN if [ $APP_ENV = "production" ]; then \
                cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini; \
                docker-php-ext-install opcache; \
        else \
                cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini; \
        fi

RUN echo 'pm.max_children = 100' >> /usr/local/etc/php-fpm.d/zz-docker.conf

CMD ["php-fpm"]

EXPOSE 9000