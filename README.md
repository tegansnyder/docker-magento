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

Change directory to docker:

* cd docker

Run vagrant from the sources directory:

* vagrant up

Access the VM and use Docker, Run vagrant ssh from the same directory:

* vagrant ssh

Once inside VM install git: 

* sudo apt-get install git

Grab the Magento repo:

* git clone https://github.com/dmahlow/docker-magento.git

Change directory to it:

* cd docker-magento

Build the docker container you can tag it something other than "magneto" if you want:

* docker build -t="magento" .

Sit back and wait for 10-15 minutes while the magic happens!

Next steps:
========================

Run your docker container:

* docker run -d magento -p :8989


Additional:
========================
If you want to find the IP of your docker interface you can ssh into it:
* ifconfig
* ssh IP.ADDR.OF.DOCKER (password vagrant)

