#!/bin/bash
set -e  # stop script if any command fails and shows which one

php-fpm -D
echo "PHP-FPM started"

php /var/www/artisan migrate --force
echo "Migrations done"

nginx -t  # test config before starting
echo "Nginx config valid"

nginx -g "daemon off;"