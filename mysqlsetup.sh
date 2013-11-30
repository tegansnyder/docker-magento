#!/bin/sh

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

/usr/sbin/mysqld &
sleep 5
echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'mysql-server' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

CREATE DATABASE magento;
CREATE USER 'magento'@'localhost' IDENTIFIED BY 'changeme';
GRANT ALL PRIVILEGES ON *.* TO 'magento'@'localhost' WITH GRANT OPTION;
CREATE USER 'magento'@'%' IDENTIFIED BY 'changeme';
GRANT ALL PRIVILEGES ON *.* TO 'magento'@'%' WITH GRANT OPTION;
