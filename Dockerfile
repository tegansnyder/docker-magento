FROM ubuntu:precise

MAINTAINER Tegan Snyder "tsnyder@tegdesign.com"

RUN echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt precise main universe multiverse' > /etc/apt/sources.list

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git mysql-client mysql-server apache2 php5 php5-curl php5-mcrypt php5-gd php5-mysql vim-tiny

RUN a2enmod rewrite

ADD apache_default_vhost /etc/apache2/sites-available/default

RUN rm -fr /var/www

RUN git clone https://github.com/magento/magento2.git /var/www/

RUN chown www-data:www-data -R /var/www

# Make mysql listen on the outside
run	sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf

EXPOSE 80

CMD ["bash", "-c", "/usr/sbin/service apache2 start && tail -f /var/log/apache2/access.log"]
