# Creating an xubuntu-wan
First I logged in to the ubuntu machine and ran the script that was created by gmcyber: https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/ubuntu-desktop.sh
now open the terminal and run the following commands:
```
sudo -i
wget https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/ubuntu-desktop.sh
```
![8.png](./images/8.png)
```
chmod +x ubuntu-desktop.sh
./ubuntu-desktop.sh
ls
```
![9.png](./images/9.png)
![10.png](./images/10.png)
Taking snapshot:
![11.png](./images/11.png)
now, in xubuntu-wan, click on edit, go to network adapter 1, change it to 480-WAN, lick on save, and finally power it on:
![12.png](./images/12.png)
```
sudo -i
adduser user3
usermod -aG sudo user3
chsh -s /bin/bash user3
```
![13.png](./images/13.png)
Now logged in as user3 and deleted user 1:
```
userdel -r user1
ls /home
id
```
![14.png](./images/14.png)
Now we need to assign it an static ip in order to get connection:
![15.png](./images/15.png)
```
sudo hostnamesctl set-hostname xubuntu-wan
```
![16.png](./images/16.png)





