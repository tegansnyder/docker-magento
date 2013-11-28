FROM ubuntu:precise

MAINTAINER Tegan Snyder "tsnyder@tegdesign.com"

RUN echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt precise main universe multiverse' > /etc/apt/sources.list

RUN apt-get update

#SHIMS
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive

# EDITORS
RUN apt-get install -y -q vim nano

# TOOLS
RUN apt-get install -y -q curl git make wget

# BUILD
RUN apt-get install -y -q build-essential g++

## PHP
RUN apt-get install -y -q php5 php5-cli php5-dev php-pear php5-fpm php5-common php5-mcrypt php5-gd php-apc php5-curl

## MAGICK
RUN apt-get install -y -q imagemagick graphicsmagick graphicsmagick-libmagick-dev-compat php5-imagick
RUN pecl install imagick

## APACHE
RUN apt-get install -y -q apache2 libapache2-mod-php5

RUN a2enmod rewrite

ADD apache_default_vhost /etc/apache2/sites-available/default

RUN rm -fr /var/www

RUN git clone https://github.com/magento/magento2.git /var/www/

RUN chown www-data:www-data -R /var/www

## MYSQL
RUN apt-get install -y -q mysql-client mysql-server php5-mysql
RUN mysqld & sleep 2 && mysqladmin create mydb

# Make mysql listen on the outside
run sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf

ENV DEBIAN_FRONTEND dialog

EXPOSE 80 3360

CMD ["bash", "-c", "/usr/sbin/service apache2 start && tail -f /var/log/apache2/access.log"]
