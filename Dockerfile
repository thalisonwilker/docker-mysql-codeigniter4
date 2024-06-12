FROM php:8.1.28-apache

# Instalar extensões PHP necessárias
RUN docker-php-ext-install mysqli

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    libzip-dev \
    cron \
    && docker-php-ext-install zip

# Criar o diretório 'comprovantes' com permissões apropriadas
RUN mkdir -p /var/www/html/comprovantes && chown -R www-data:www-data /var/www/html/comprovantes

# Adicionar o usuário www-data ao grupo www-data para garantir permissões adequadas
RUN usermod -a -G www-data www-data

# Permitir que www-data tenha acesso a todo o conteúdo de /var/www/html
RUN chown -R www-data:www-data /var/www/html && chmod -R 775 /var/www/html
