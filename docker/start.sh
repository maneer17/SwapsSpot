#!/bin/sh
set -e

echo "Running migrations..."
php artisan migrate --force || true

echo "Caching config..."
php artisan config:cache
php artisan route:cache

echo "Starting server..."
php artisan serve --host=0.0.0.0 --port=8000