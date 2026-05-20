FROM php:5.6-fpm-stretch

# Actualizar repositorios antiguos (stretch está en el archivo histórico)
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list

# Instalar dependencias ignorando firmas GPG expiradas
RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    libfreetype6-dev \
    libzip-dev \
    zlib1g-dev \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Configurar e instalar extensiones de PHP indispensables para Moodle 3.0
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mysqli opcache xml xmlrpc zip soap mbstring

# Configuración recomendada de PHP
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=60'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Descargar Moodle 3.0.1
WORKDIR /var/www/html
RUN curl -L https://github.com/moodle/moodle/archive/refs/tags/v3.0.1.tar.gz -o moodle.tar.gz \
    && tar -xf moodle.tar.gz --strip-components=1 \
    && rm moodle.tar.gz \
    && chown -R www-data:www-data /var/www/html

# Crear el directorio moodledata fuera de la raíz web
RUN mkdir -p /var/www/moodledata \
    && chown -R www-data:www-data /var/www/moodledata