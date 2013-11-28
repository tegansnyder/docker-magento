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

2. Change directory to docker
cd docker

3. Run vagrant from the sources directory
vagrant up

4. Next: To access the VM and use Docker, Run vagrant ssh from the same directory.
vagrant ssh

5. Once inside VM install git: 
sudo apt-get install git

6. grab the Magento repo
git clone https://github.com/dmahlow/docker-magento.git

7. change directory to it
cd docker-magento

8. build the docker container
docker build .

