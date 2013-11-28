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

Build the docker container you can tag it something other than "magneto" if you want:

* sudo docker build -t="magento" .

Sit back and wait for 10-15 minutes while the magic happens!

Next steps (Still ssh'd inside docker VM):
========================

Run your docker container by default it exposes port 80 if you want to override it use a colon:

* sudo docker run -p 8989:80 -d magento

Then configure virtual box to port forward that port so you can access it from you web browser:

![alt text](https://raw.github.com/tegansnyder/docker-magento/master/vm-settings.png "Virtual Box Settings")

Note after you make this change you will need to:
* vagrant ssh
* sudo /etc/init.d/networking restart

Final steps (exiting your docker VM ssh session or opening a new terminal tab):
========================

On your local computer not the VM create a host entry:
* sudo vi /private/etc/hosts

Add some entries:
* 127.0.0.1 magento.dev
* 127.0.0.1 www.magento.dev

Finally open your web browser to start the Magento installation:
* http://www.magento.dev:8989/


Additional:
========================

Listing docker containers:
* docker ps

Stopping a docker container:
* docker stop CONTAINERID

If you want to find the IP of your docker interface you can ssh into it:
* docker inspect CONTAINERID
