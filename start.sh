#!/bin/bash
if [ ! -f .env ]; then cp .env.save .env; fi
php artisan key:generate --force || true
php artisan migrate --force || true
sed -i 's|listen = .*|listen = 127.0.0.1:9000|' /usr/local/etc/php-fpm.d/www.conf
echo "server { listen ${PORT}; root /var/www/html/public; index index.php; location / { try_files \$uri \$uri/ /index.php?\$query_string; } location ~ \.php$ { fastcgi_pass 127.0.0.1:9000; fastcgi_index index.php; include fastcgi_params; fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name; } }" > /etc/nginx/sites-available/default
php-fpm
exec nginx -g 'daemon off;'
