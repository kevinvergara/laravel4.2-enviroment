FROM php:5.6-apache

LABEL Name=laravel4.2 Version=1.0.1

#hacer que la consola no sea interactiva
ENV DEBIAN_FRONTEND=noninteractive
#--------------------------------

#instalar apache y php
RUN apt-get update

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libpcre3-dev \
        libxml2-dev

RUN docker-php-ext-install mcrypt gd mbstring pdo pdo_mysql zip xml

#soap
RUN docker-php-ext-install soap

#mongo
#RUN pecl install mongo && docker-php-ext-enable mongo

#herramientas utiles
RUN apt-get install -y wget && \
    apt-get install -y curl && \
        apt-get install -y nano

#-------------------------

# memory limit php
RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/memory-limit.ini
#---------------------------------------------------------------------

# limite de archivos
RUN echo "file_uploads = On \n memory_limit = 64M \n upload_max_filesize = 64M \n post_max_size = 64M \n max_execution_time = 600" > /usr/local/etc/php/conf.d/uploads.ini
#---------------------------------------------------------------------------

#composer, git y node
RUN apt-get update && \
    curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN apt-get install -y git-core openssl libssl-dev python3
#----------------------

# Cleanup
RUN apt-get autoremove -y
#---------------------

#configurar proyecto
EXPOSE 80

ENV APP_HOME /var/www/html

RUN mkdir -p /opt/data/public && \
    rm -r /var/www/html && \
    ln -s /opt/data/public $APP_HOME

#--------traer config de apache--------
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD 000-default.conf /etc/apache2/sites-enabled
#===============================================

RUN a2enmod rewrite

WORKDIR /opt/data
