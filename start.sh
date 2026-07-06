#!/bin/bash
rm -f /etc/apache2/mods-enabled/mpm_event.load /etc/apache2/mods-enabled/mpm_event.conf /etc/apache2/mods-enabled/mpm_prefork.load /etc/apache2/mods-enabled/mpm_prefork.conf
a2enmod mpm_prefork rewrite
mkdir -p /var/www/html/tagxi-super/public/push-configurations
echo '{"type":"service_account"}' > /var/www/html/tagxi-super/public/push-configurations/bidding_firebase.json
if [ ! -f .env ]; then
  cp .env.save .env
fi
php artisan key:generate --force || true
php artisan migrate --force || true
sed -i "s/Listen 80/Listen ${PORT}/g" /etc/apache2/ports.conf
sed -i "s/*:80/*:${PORT}/g" /etc/apache2/sites-available/000-default.conf
exec apache2-foreground
