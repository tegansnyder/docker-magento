FROM centos:6.4
MAINTAINER Tegan Snyder <tsnyder@tegdesign.com>

# INSTALL http
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# INSTALL httpd
RUN yum -y install httpd vim-enhanced bash-completion unzip

# EDITORS
RUN yum install -y vim nano

# TOOLS
RUN yum install -y curl git make wget

# INSTALL mysql
RUN yum install -y mysql mysql-server
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# Make mysql listen on the outside
run sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf

# start mysqld to create initial tables
RUN service mysqld start

# INSTALL php
RUN yum install -y php php-pdo php-soap php-devel php-pecl-apc php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml php-mcrypt

# INSTALL supervisord
RUN yum install -y python-pip && pip install pip --upgrade
RUN pip install supervisor

# INSTALL sshd
RUN yum install -y openssh-server openssh-clients passwd

RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:changeme' | chpasswd

#ADD phpinfo.php /var/www/html/

RUN rm -fr /var/www/html

RUN git clone https://github.com/magento/magento2.git /var/www/html/

ADD supervisord.conf /etc/

EXPOSE 22 80 3360

CMD ["supervisord", "-n"]
