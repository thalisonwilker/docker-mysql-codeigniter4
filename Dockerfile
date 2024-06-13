# Use the official PHP image with Apache
FROM php:8.1-apache

# Update packages and install necessary dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo pdo_mysql mysqli zip

# Configure Apache DocumentRoot to serve from the 'public' directory
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy the project files to the container
COPY ./codeigniter4.5.2-0 /var/www/html

# Ensure the writable directory has the correct permissions
RUN chown -R www-data:www-data /var/www/html/writable \
    && chmod -R 755 /var/www/html/writable


RUN chown -R www-data:www-data /var/www/html/writable/cache/
RUN chmod -R 755 /var/www/html/writable/cache/
RUN chmod -R 777 /var/www/html/*

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
