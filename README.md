
# H7: Oma moduuli / Palvelinten hallinta ICT4TN022-3013 2022 Kevät

This project is meant to be ran with [https://saltproject.io/](SaltStack) to install the LAMP-stack with custom configurations (Linux, Apache, MySql(MariaDB) and Php).

## How to run?

You can run these states locally only using salt-minion, however to run these states in a master-minion architecture a salt-master installation is also required. 
(A decent guide for this can be found at: http://terokarvinen.com/2018/salt-quickstart-salt-stack-master-and-slave-on-ubuntu-linux/)

## Project progress
<B>Project status:</b> Beta

First of all I started on two fresh Debian 11 installations on VMWare Workstation 16.2.3 build-19376536 with default settings.
On the master VM I added myself to sudoers through /etc/sudoers and ran:

		$ sudo apt-get update
		$ sudo apt-get install salt-master
		
I checked my local IP through the command:

		$ hostname -I 
	
for later usage.
	
On the minion VM I added myself to sudoers through /etc/sudoers and ran:

		$ sudo apt-get update
		$ sudo apt-get install salt-minion
		
After the installation I edited /etc/salt/minion to include the lines:

		master: <IP of the master>
		id: debianminion
		
and that's the configuration for the minion done, afterwards accepted the minions key on the master VM. Might have to restart the daemon for it to connect to the master.
Tested with

		$ sudo salt '*' test.ping
		
on the master and it works.

Now all that's left to do is to make the directories for the salt-states on the master VM, I've decided to make a separate folder for each application to keep them somewhat organized, installation and configurations in the same folder.

![Tree](https://raw.githubusercontent.com/Jimitesti/h7moduli/main/Pictures/tree.png)
```YAML
/srv/salt/mariadb/init.sls
mariadb-server:
  pkg.installed
```
````YAML
/srv/salt/apache/init.sls
apache2:
  pkg.installed
a2enmod:
  cmd.run:
    - name: "a2enmod userdir"
    - creates: "/etc/apache2/mods-enabled/userdir.conf"
````
````YAML
/srv/salt/php/init.sls
php:
  pkg.installed
phpmyadmin:
  pkg.installed
````
And there we have the basic LAMP-stack installed with phpmyadmin aswell.

![Test](https://raw.githubusercontent.com/Jimitesti/h7moduli/main/Pictures/test.png)

Tested this on my debian minion and it successfully installed everything, now everything that's left is to configure.
I don't know who needs to use it but it's public for anyone to use, I'm using it myself just to learn PHP.

To do:

Configurations

Make some test databases for MariaDB with salt states.