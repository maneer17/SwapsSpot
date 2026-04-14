#!/bin/bash
php-fpm -D
php /var/www/artisan migrate --force
nginx -g "daemon off;"