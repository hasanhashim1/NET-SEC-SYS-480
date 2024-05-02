# Milestone X - FOG

For this project I used one of the Rocky VMs that I had. I edited it by adding the second Hard 
You can also donwload the ISO Rocky from here: [Rocky ISO](https://rockylinux.org/download/)

![1.png](./Images/1.png)

You need to set you hostname to fog and static IP of 10.0.17.5. if you don't know how to do that here are the command: ` sudo nmtui` and then click on Set system … and set you hostname:

![1.0.png](./Images/1.0.png)

After you done from the hostname click on Edit a connection to set up static IP and disable IPV6. After that reboot the system and you see everything is configured:

![1.1.png](./Images/1.1.png)

#### Fog Installation Tasks
Now we are going to mount the second drive using the following command:
`fdisk -l` to see the drives that you have in the system. `/dev/sdb` is the unpartitioned disk. 
![2.1.png](./Images/2.1.png)

To use that drive we need to mount it, to do that we need to use the following commands:
```
fdisk /dev/sdb
Next it will ask you to wire the partition.
`w`
fdisk -l
```

![2.2.png](./Images/2.2.png)

Now we going to create the ext4 file system:

![2.3.png](./Images/2.3.png)
we need to have git installed to clone the Fog project from the github: 
```
yum install git
git clone https://github.com/FOGProject/fogproject.git
```
After that go /fogproject/bin/ and run the installfog.sh:
* Follow Devin's video: [Video 5.2](https://drive.google.com/file/d/1iL0guYnOPxmIChsfxkMSZIFyU02XcxWC/view?usp=sharing)
* or follow this link: https://www.ceos3c.com/linux/install-fog-server-ubuntu-server/
  
![2.png](./Images/2.png)
![3.png](./Images/3.png)

When it is done it will give you username and password to login using GUI web based:

![4.png](./Images/4.png)

Now when you login I advise you to change you password, as shown below:

![5.png](./Images/5.png)
![6.png](./Images/6.png)

Make suer to add the following into your DHCP server:

![7.png](./Images/7.png)
![8.png](./Images/8.png)

Now we have to create an image to tell FOG to get ready to capuer the image: 

![9.png](./Images/9.png)
![10.png](./Images/10.png)

Using my cloner script I made two clone one is the base and the other is used to get the image:

![11.png](./Images/11.png)
![12.png](./Images/12.png)

Make suer you have the following boot order:

![13.png](./Images/13.png)

Now go to Quick Registration and Inventory:

![14.png](./Images/14.png)

Now go to the fog web based and click on hosts → List All Hosts → caputer
![15.png](./Images/15.png)

Slecte xubuntu-20-02 - (2)

![16.png](./Images/16.png)
![17.png](./Images/17.png)

Now you should see this which means we are at the right path to captuer the image:

![18.png](./Images/18.png)

Now create a new VM and powered on. you will see this which a really good sign, click on Deply Image:

![20.png](./Images/20.png)

Now it will ask you login with you account:

![21.png](./Images/21.png)

After that select the image you want to use in my case I only have one which is xubuntu:

![22.png](./Images/22.png)

After a while you should be able to see your VM booting up with your image:

![23.png](./Images/23.png)







