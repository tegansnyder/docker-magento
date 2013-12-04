#!/bin/bash
/usr/bin/mysqld_safe &
sleep 10
/usr/bin/mysql -u root -e "CREATE DATABASE magento; CREATE USER 'magento'@'localhost' IDENTIFIED BY 'changeme'; GRANT ALL PRIVILEGES ON *.* TO 'magento'@'localhost' WITH GRANT OPTION; CREATE USER 'magento'@'%' IDENTIFIED BY 'changeme'; GRANT ALL PRIVILEGES ON *.* TO 'magento'@'%' WITH GRANT OPTION;"
