#!/bin/bash
if [ ! -f .env ]; then
  cp .env.save .env
fi
php artisan key:generate --force || true
php artisan migrate --force || true
apachectl start
