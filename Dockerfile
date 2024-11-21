# Base image with PHP 8.4 and Apache
FROM php:8.3-apache

# Update and install necessary extensions for PHP and tools
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    mariadb-client \
    && docker-php-ext-install mysqli pdo_mysql zip \
    && a2enmod rewrite \
    && apt-get clean

# Set the working directory in the container
WORKDIR /var/www/html

# Copy project files to the container
COPY . /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]