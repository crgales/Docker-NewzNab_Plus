FROM ubuntu:20.04
MAINTAINER Chuck Gales <cgales@gmail.com> - Branched from Cameron Meindl <cmeindl@gmail.com>

#install the Pre Reqs and Apache
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get -yq install php php-dev php-pear php-gd php-mysql php-curl \
    mysql-client libmysqlclient-dev apache2 subversion unrar-free lame software-properties-common mediainfo supervisor

ENV php_timezone America/New_York
ENV path /:/var/www/html/www/

# add the Config to Apache
ADD ./newznab.conf /etc/apache2/sites-available/newznab.conf

#fix the config files for PHP
RUN sed -i "s/max_execution_time = 30/max_execution_time = 120/" /etc/php/7.4/cli/php.ini  && \
sed -i "s/memory_limit = -1/memory_limit = 1024M/" /etc/php/7.4/cli/php.ini  && \
echo "register_globals = Off" >> /etc/php/7.4/cli/php.ini  && \
echo "date.timezone =$php_timezone" >> /etc/php/7.4/cli/php.ini  && \
sed -i "s/max_execution_time = 30/max_execution_time = 120/" /etc/php/7.4/apache2/php.ini  && \
sed -i "s/memory_limit = -1/memory_limit = 1024M/" /etc/php/7.4/apache2/php.ini  && \
echo "register_globals = Off" >> /etc/php/7.4/apache2/php.ini  && \
echo "date.timezone =$php_timezone" >> /etc/php/7.4/apache2/php.ini  && \
sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php/7.4/apache2/php.ini

# Disable Default site and enable newznab site - Restart Apache here to confirm your newznab.conf is valid in case you changed it
RUN a2dissite 000-default.conf
RUN a2ensite newznab
RUN a2enmod rewrite
RUN service apache2 restart

#add newznab processing script
ADD ./newznab.sh /newznab.sh
RUN chmod 755 /*.sh

#Setup supervisor to start Apache and the Newznab scripts to load headers and build releases
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup Newznab volume this will need to be mapped locally using -v command so that it can persist.
EXPOSE 80
VOLUME /var/www/newznab
WORKDIR /var/www/newznab

#kickoff Supervisor to start the functions
CMD ["/usr/bin/supervisord"]
