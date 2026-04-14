#!/bin/bash
set -e

# Fix permissions at runtime
chown -R nginx:nginx /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

php-fpm -D
echo "PHP-FPM started"

php /var/www/artisan config:cache
php /var/www/artisan route:cache
php /var/www/artisan migrate --force
echo "Migrations done"

nginx -t
nginx -g "daemon off;"