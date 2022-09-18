FROM php:8-fpm

RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install \
        intl \
    && docker-php-ext-enable \
        intl

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
        zip \
        ffmpeg \
		libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-configure exif \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install exif \
	&& docker-php-ext-enable exif

RUN mkdir -p /home/deluge/complete \
    && mkdir -p /home/deluge/incomplete \
    && mkdir -p /home/deluge/watch \
    && mkdir -p /home/deluge/torrentfiles 

COPY ./helper /home/deluge/

RUN chmod 777 /home/deluge/
RUN chown -R root:www-data /home/deluge/complete
RUN chmod g+w -R /home/deluge/complete
RUN chown -R root:www-data /home/deluge/incomplete
RUN chmod g+w -R /home/deluge/incomplete
RUN chown -R root:www-data /home/deluge/watch
RUN chmod g+w -R /home/deluge/watch
RUN chown -R root:www-data /home/deluge/torrentfiles
RUN chmod g+w -R /home/deluge/torrentfiles