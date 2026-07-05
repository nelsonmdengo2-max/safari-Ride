FROM php:8.2-apache
RUN apt-get update && apt-get install -y libpng-dev libjpeg62-turbo-dev libfreetype6-dev libzip-dev unzip curl libicu-dev libonig-dev libxml2-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd zip pdo pdo_mysql mysqli bcmath mbstring xml intl opcache
RUN a2enmod rewrite
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html
COPY . .
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts
RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html/storage && chmod -R 775 /var/www/html/bootstrap/cache
COPY start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 80
CMD ["/start.sh"]
