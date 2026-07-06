#!/bin/bash
a2dismod -f mpm_event 2>/dev/null
a2enmod mpm_prefork rewrite 2>/dev/null
mkdir -p /var/www/html/tagxi-super/public/push-configurations
echo '{"type":"service_account","project_id":"dummy","private_key_id":"dummy","private_key":"dummy","client_email":"dummy","client_id":"dummy"}' > /var/www/html/tagxi-super/public/push-configurations/bidding_firebase.json
if [ ! -f .env ]; then
  cp .env.save .env
fi
php artisan key:generate --force || true
php artisan migrate --force || true
sed -i "s/Listen 80/Listen ${PORT}/g" /etc/apache2/ports.conf
sed -i "s/*:80/*:${PORT}/g" /etc/apache2/sites-available/000-default.conf
exec apache2-foreground
