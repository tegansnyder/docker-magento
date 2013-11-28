FROM ubuntu:precise

MAINTAINER Tegan Snyder "tsnyder@tegdesign.com"

RUN echo 'deb mirror://mirrors.ubuntu.com/mirrors.txt precise main universe multiverse' > /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install mysql-client mysql-server apache2 php5 php5-curl php5-mcrypt php5-gd php5-mysql vim-tiny

RUN a2enmod rewrite

ADD apache_default_vhost /etc/apache2/sites-available/default

ADD http://www.magentocommerce.com/downloads/assets/1.8.0.0/magento-1.8.0.0.tar.gz /root/
ADD http://www.magentocommerce.com/downloads/assets/1.6.1.0/magento-sample-data-1.6.1.0.tar.gz /root/

RUN rm -fr /var/www
RUN mv /root/magento /var/www
RUN mv /root/magento-sample-data-1.6.1.0/media/* /var/www/media/

RUN chown www-data:www-data -R /var/www

# Install mysql-server in non-interactive mode
run	bash -c "export DEBIAN_FRONTEND=noninteractive; apt-get -q -y install mysql-server-5.5"

# Make mysql listen on the outside
run	sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf

EXPOSE 80 3306

CMD ["bash", "-c", "/usr/sbin/service apache2 start && tail -f /var/log/apache2/access.log"]
