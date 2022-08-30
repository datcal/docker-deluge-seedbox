FROM debian:jessie
LABEL MAINTAINER="Burak Hamza"

# Install components
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get --no-install-recommends -qyy install sudo deluged deluge-web deluge-console runit psmisc nginx 

RUN apt-get --no-install-recommends -qyy php8-fpm unzip wget php8-gd 
RUN apt-get --no-install-recommends -qyy libav-tools zip imagemagick 
RUN apt-get --no-install-recommends -qyy apache2-utils && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Configure nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/sites-available/default

# Configure runit
ADD deluged.service /etc/service/deluged/run
ADD deluge-web.service /etc/service/deluge-web/run
ADD php5-fpm.service /etc/service/php5-fpm/run
ADD nginx.service /etc/service/nginx/run

ADD core.conf /tmp/core.conf
WORKDIR /home/deluge

COPY file.php /home/deluge/file.php

RUN sudo chmod 777 /home/deluge/

# Expose ports
EXPOSE 80
EXPOSE 8112
EXPOSE 58846
EXPOSE 58847
EXPOSE 58847/udp

VOLUME /home/deluge
VOLUME /home/deluge/incomplete
VOLUME /home/deluge/complete
VOLUME /home/deluge/watch
VOLUME /home/deluge/torrentfiles

CMD ["runsvdir", "/etc/service"]
