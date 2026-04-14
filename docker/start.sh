#!/bin/bash
set -e

php-fpm -D
echo "PHP-FPM started"

# Fix storage permissions at runtime
chmod -R 775 /var/www/storage
chmod -R 775 /var/www/bootstrap/cache

php /var/www/artisan config:cache
php /var/www/artisan route:cache

php /var/www/artisan migrate --force
echo "Migrations done"

nginx -t
nginx -g "daemon off;"