Welcome
========================
This will install a docker container with Magento CE 1.8. You can easily change the Dockerfile to pull in a different Magento repo. If you are using a private repo make sure to do your git clone -v

@TODO: 
* Update PHP to version 5.5 to support Magento 2. Add REMI / EPEL repos to get MySQL 5.5 and PHP 5.5.

Getting Started
========================

Requirements:

Install Git:
* http://git-scm.com/downloads

Install VirtualBox:
* https://www.virtualbox.org/

Install Vagrant:
* http://downloads.vagrantup.com/

Install Docker:
* git clone https://github.com/dotcloud/docker.git


Running the docker container:
========================

Change directory to docker:

* cd docker

Run vagrant from the sources directory:

* vagrant up

Access the VM and use Docker, Run vagrant ssh from the same directory:

* vagrant ssh

Once you are ssh'd inside the docker VM
========================

Install git:

* sudo apt-get install git

Grab the Magento repo:

* git clone https://github.com/tegansnyder/docker-magento.git

Change directory to it:

* cd docker-magento

* Optionally change the root SSH password in the Dockerfile defaults to "changeme"

Build the docker container you can tag it something other than "magneto" if you want:

* sudo docker build -t="magento" .

###### Sit back and wait for 10-15 minutes while the magic happens!

When finished building you will need to run your docker container. By default it exposes port 80 but I suggest you override it to a non-standard port:

* sudo docker run -p 8989:80 -d magento

Then configure virtual box to port forward that port so you can access it from you web browser:

![alt text](https://raw.github.com/tegansnyder/docker-magento/master/vm-settings.png "Virtual Box Settings")

Note after you make this change you will need to:
* vagrant ssh
* sudo /etc/init.d/networking restart

Final steps
========================

On your local computer not the VM create a host entry:
* sudo vi /private/etc/hosts

Add some entries:
* 127.0.0.1 magento.dev
* 127.0.0.1 www.magento.dev

Finally open your web browser to start the Magento installation:
* http://www.magento.dev:8989/

Note: the mysql database and password are set in "mysqlsetup.sh" not "setup.sql"... the screenshot below is wrong:
![alt text](https://raw.github.com/tegansnyder/docker-magento/master/magento-setup.png "Magento Setup")

Additional:
========================

Listing docker containers:
* docker ps

Stopping a docker container:
* docker stop CONTAINERID

If you want to find the IP of your docker interface you can ssh into it:
* docker inspect CONTAINERID

Once you find the IP of it you can SSH from your Vagrant VM into your Docker VM if you need to tune anything using the password you set in the Dockerfile... (defaults to "changeme")
* ssh root@DOCKER_IP

If you make some changes to the Dockerfile you can rebuild the container without having to go through the whole installation. Simply stop the docker container then issue:
* docker build -rm .
