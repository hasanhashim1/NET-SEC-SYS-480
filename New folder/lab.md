# Milestone 3 - vCenter
Add the ISO image into the CD of the xubuntu:

![1.png](./Images/1.png)

Locate that CD and see if it is connected:

![2.png](./Images/2.png)

Now open the terminal and go to /media/user3/VMWare VCSA/vcsa-ui-installer/lin64 and type ./installer:
```
cd /media/user3/VMWare VCSA/vcsa-ui-installer/lin64
./installer
```
Now you should see the vCenter Server 8.0 Installer, form here click Install:
![3.png](./Images/3.png)

Here click on next:

![4.png](./Images/4.png)

Check the Box and click on Next:

![5.png](./Images/5.png)

Here type the IP address of the ESXi in my case it is 192.168.7.20, add a user name and a password, as shown below:

![6.png](./Images/6.png)

Type a name of the vcenter as shown below:

![7.png](./Images/7.png)

Here leave it as is and click on Next:

![8.png](./Images/8.png)

Here configure the network for the vCenter in my case I assgin an ip of 10.0.17.3, after that click on Next:

![10.png](./Images/10.png)

Rreview and click on Finish:

![11.png](./Images/11.png)

Wait for it to finish up loading:

![12.png](./Images/12.png)

Untill you see this and click on Close:

![13.png](./Images/13.png)

Click Next:

![14.png](./Images/14.png)

Select Sysnchronize time with the NTP servers and click on next:

![15.png](./Images/15.png)

Add the following and click on Next:

![16.png](./Images/16.png)

Check the box and click Next
![17.png](./Images/17.png)

Review and click on Finish:

![18.png](./Images/18.png)

Wait untill it done processing:

![19.png](./Images/19.png)

After it is done you will see this click in the blue link and that will send you to the vCenter:

![20.png](./Images/20.png)

Login to vCenter:
![21.png](./Images/21.png)

You should see this page after logging in:

![22.png](./Images/22.png)

Right click on 10.0.17.3 and click on New Datacenter:

![23.png](./Images/23.png)

Name it, in my case I named it 480-DevOps-DataCenter:

![24.png](./Images/24.png)

After that right click on it and click on Add Host...:

![25.png](./Images/25.png)

Add the ip of the ESXi , in my case 192.168.7.20:

![26.png](./Images/26.png)

Add the user name and password for the ESXi:

![27.png](./Images/27.png)

Now you should the VMs listed as shown below:

![28.png](./Images/28.png)

From here just go on with defult steps:

![29.png](./Images/29.png)
![30.png](./Images/30.png)
![31.png](./Images/31.png)
![32.png](./Images/32.png)

Now if you did everything correct you shoudl see this:

![33.png](./Images/33.png)









