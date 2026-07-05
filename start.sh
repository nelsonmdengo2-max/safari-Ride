#!/bin/bash
if [ ! -f .env ]; then
  cp .env.save .env
fi
php artisan key:generate --force
apache2-foreground
