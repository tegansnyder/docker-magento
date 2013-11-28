Getting Started
========================

Requirements:

Install VirtualBox:
https://www.virtualbox.org/

Install Vagrant:
http://downloads.vagrantup.com/

Install Docker:
git clone https://github.com/dotcloud/docker.git


Running the docker container:
========================

* Change directory to docker

cd docker

* Run vagrant from the sources directory

vagrant up

* Next: To access the VM and use Docker, Run vagrant ssh from the same directory.

vagrant ssh

* Once inside VM install git: 

sudo apt-get install git

* grab the Magento repo

git clone https://github.com/dmahlow/docker-magento.git

* change directory to it

cd docker-magento

* build the docker container you can tag it something other than "magneto" if you want

docker build -t="magento" .

* Sit back and wait for 10-15 minutes while the magic happens

Next steps:
========================

* Find the IP of your docker interface

ifconfig

* ssh IP.ADDR.OF.DOCKER (password vagrant)

