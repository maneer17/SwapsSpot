FROM php:8.3-cli-alpine

# System dependencies
RUN apk add --no-cache \
    bash curl git zip unzip \
    libpng-dev oniguruma-dev libxml2-dev postgresql-dev

# PHP extensions
RUN docker-php-ext-install \
    pdo pdo_mysql mbstring exif pcntl bcmath gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copy composer first (better caching)
COPY composer.json composer.lock ./

RUN composer install --no-dev --optimize-autoloader --no-scripts

# Copy full project
COPY . .

RUN composer dump-autoload --optimize

# Permissions (only needed for Laravel)
RUN chown -R www-data:www-data storage bootstrap/cache || true

EXPOSE 8000

# Railway expects HTTP server → artisan serve
CMD ["/bin/sh", "docker/start.sh"]