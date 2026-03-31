# Dockerfile for PHP 8.2 FPM Alpine with PostgreSQL extension and Composer

# Use PHP 8.2 FPM Alpine as base image
FROM php:8.2-fpm-alpine

# Install dependencies for PostgreSQL and Composer
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    zlib-dev \
    postgresql-dev \
    git \
    unzip \
    && docker-php-ext-configure gd --with-jpeg --with-webp --with-xpm \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_pgsql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY . .

# Install Laravel dependencies via Composer
RUN composer install

# Expose the port PHP-FPM is running on
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]