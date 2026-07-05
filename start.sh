#!/bin/bash
if [ ! -f .env ]; then
  cp .env.save .env
fi
php artisan key:generate --force || true
php artisan migrate --force || true
sed -i "s/80/${PORT}/g" /etc/apache2/ports.conf
sed -i "s/80/${PORT}/g" /etc/apache2/sites-available/000-default.conf
apachectl start
