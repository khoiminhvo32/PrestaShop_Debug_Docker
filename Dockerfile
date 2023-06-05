# To run files with the same group as your primary user
ARG VERSION

FROM prestashop/base:$VERSION

EXPOSE 443

ARG GROUP_ID
ARG USER_ID

RUN groupmod -g $GROUP_ID www-data \
  && usermod -u $USER_ID -g $GROUP_ID www-data

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions xdebug

COPY .docker/wait-for-it.sh /tmp/
COPY .docker/docker_run_git.sh /tmp/
COPY config/docker-php-ext-xdebug.ini "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini"
COPY config/php.ini /usr/local/etc/php/conf.d/

RUN docker-php-ext-enable xdebug

RUN mkdir -p /var/www/.npm
RUN chown -R www-data:www-data /var/www/.npm
RUN mkdir -p /var/www/.composer
RUN chown -R www-data:www-data /var/www/.composer

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt install -y nodejs

# Install mailutils to make sendmail work
RUN apt install -y \
    apt-utils \
    mailutils

RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer && rm -rf /tmp/composer-setup.php
CMD ["/tmp/docker_run_git.sh"]
