ARG PHP_TAG

FROM php:$PHP_TAG

ARG USERNAME
ARG UID
ENV USERNAME=$USERNAME
ENV UID=$UID

RUN apt-get update && \
    apt-get install -y zip unzip git curl libzip-dev libmcrypt-dev libonig-dev mariadb-client openssl

RUN git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis && \
    docker-php-ext-install pdo_mysql redis

## install composer.phar
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

## add user
RUN useradd --create-home --shell /bin/bash --uid $UID $USERNAME

## copy php.ini, *.sh
COPY ["php.ini" ,"/usr/local/etc/php/php.ini"]
COPY --chown=$USERNAME:$USERNAME setup_laravel.sh /tmp/setup_laravel.sh
RUN chmod +x /tmp/setup_laravel.sh

USER $USERNAME
WORKDIR /var/www/html


