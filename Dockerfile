FROM php:8.2-fpm
RUN apt-get update && apt-get install -y libpng-dev libjpeg62-turbo-dev libfreetype6-dev libzip-dev unzip curl libicu-dev libonig-dev libxml2-dev nginx
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd zip pdo pdo_mysql mysqli bcmath mbstring xml intl opcache
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html
COPY . .
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts
RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html/storage && chmod -R 775 /var/www/html/bootstrap/cache
RUN mkdir -p /var/www/html/tagxi-super/public/push-configurations
RUN echo '{"type":"service_account","project_id":"d","private_key_id":"d","private_key":"d","client_email":"d@d.d","client_id":"d","auth_uri":"d","token_uri":"d"}' > /var/www/html/tagxi-super/public/push-configurations/bidding_firebase.json
COPY start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 80
CMD ["/start.sh"]
