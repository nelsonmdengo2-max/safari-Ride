#!/bin/bash
if [ ! -f .env ]; then
  cp .env.save .env
fi
php artisan key:generate --force
php artisan migrate --force
apache2-foreground
