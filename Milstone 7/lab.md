# Milestone 7 - Deploying and Post Provisioning of BlueX Linux Servers

💡In this module, we will be deploying 5 linux servers directly to a DHCP enabled BlueX LAN:(3 Rocky Linux and 2 Ubuntu).  Network configuration on FW-Blue1 will be adjusted similarly to the way we provision vyos.  We will then adjust the networking configuration on 5 linux hosts.

10.0.5.5 may be used in some of these demos/configs - we haven’t set that up yet
## 7.1 Create a Rocky 9.1 Base VM
Create a Rocky Linux 9.1 Base VM from the minimal.iso file shown below, you should have enough information to make this happen.  Make sure it is thin provisioned.  The following [script](https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/rhel-sealer.sh) can be run to prepare the virtual machine.

**![](https://lh7-us.googleusercontent.com/nsjf-SiOqAnH_LYePnNRY0MggEKjr4dhtEl8sadSctTj0Rw3bSoBc8oycfjHIYzrVPeaXTA_aSjXRCwYfadj4UobyuPdSXlRquecgMObegRJ4wqm-_QFIWr-jLXw2AYol8tAHzuW_wdMXYaJXmrwmNM)
## 7.2 DHCP Services on fw-blue1 and a static (or dynamic) route on 480-fw
*   Create a static route on 480-fw such that 480-WAN traffic destined to the BLUE network IP space (10.0.5.0/24) is routed to the fw-blue1's eth0 interface
*   *   You can just console/ssh into 480-FW to create the static rule- no need to get fancy!
*   Using an ansible playbook, create the DHCP pool on fw-blue1
*   *   Couple of tasks:
    *   *   Inventory file: Using .yml instead of txt for the inventory file.  Just a different way to store the variables for the playbook and is a bit more scalable than .txt**

***   Playbook file: For this milestone, you will use the ansible vyos modules to write commands to fw-blue1.  (as opposed to the the last milestone where we replaced the config file)
*   *   To have ansible run vyos commands (e.g. something like “show version” can use the ansible [vyos\_command module](https://docs.ansible.com/ansible/latest/collections/vyos/vyos/vyos_command_module.html#ansible-collections-vyos-vyos-vyos-command-module) for relevant tasks
    *   To have ansible add/remove “lines” from the vyos configuration, can use the ansible [vyos\_config module](https://docs.ansible.com/ansible/latest/collections/vyos/vyos/vyos_config_module.html)
*   Tips: Here is an example of a DHCP server config for vyos - just to save you some time from looking up the commands
*   *   BLUE1 is the name given to the network just to help with the configurationservice {     dhcp-server {         global-parameters "local-address 10.0.5.2"         shared-network-name BLUE1 {             authoritative             subnet 10.0.5.0/24 {                 default-router 10.0.5.2                 domain-name blue1.local                 lease 86400                 name-server 10.0.5.5                 range BLUE1--POOL {                     start 10.0.5.75                     stop 10.0.5.125                 }             }         }     }*   So, you should be able to figure out the command for each line, e.g.set service dhcp-server shared-network-name BLUE1 subnet 10.0.5.0/24 lease 86400*   Demonstration [video](https://drive.google.com/file/d/16QN_pd2rrV74KRyWNKC_vKtoY1qEoiMB/view?usp=sharing)
*   Using your version of 480-utils, create 3 rocky linked clones that land on the BLUE network, picking up a DHCP address.
*   Demonstration [video](https://drive.google.com/file/d/1RNTUu_Q8oMyByCox28Hg1iCUROOlb4vO/view?usp=sharing)**

## 7.3 Post Provisioning Rocky-1-3 with Ansible
*   Your ansible playbook should do the following:
*   *   add a public key for the deployer user
    *   create a sudoers drop-in file for no password elevation to root by deployer
    *   change the hostname
    *   change the dhcp ip address to static (10.0.5.10,11,12)Demonstration [video](https://drive.google.com/file/d/1KwNME-Vji3SvGrjl3CP8-dHzcFQDTCjP/view?usp=sharing)**

## 7.4  Post Provisioning Ubuntu 1-2 with Ansible
Repeat the 7.3 requirements with ubuntu.
 Deliverable 3.  Video demonstration showing successful ansible run for post provisioning of Ubuntu 1-2.  Walk through your playbook and inventory file for this part of the deliverable.  Use static IP addresses of 10.0.5.30 and 10.0.5.31 for Ubuntu 1 and 2 respectively.**



# Lab Sloution
Download the Rock iso image from the following link:
https://dl.rockylinux.org/vault/rocky/9.1/isos/x86_64/

Now we have ot create a new VM for the Rocky: 

*   Click on virtual machines on the navigator menu image
*  Select a name and gues OS - in my case I named it "Rocky"

![1.png](./Images/1.png)

*   Select storage image:
*   Default settings 4.Customize settings
*   Hard disk: open drop down
    *   Disk provisioning: **Thin provisioned**
*   Network Adapter 1: 480-WAN-PortGroup
*   CD/DVD Drive: Datastore ISO file
    *   You will be brought back to the isos file, select the ISO image where you downloaded

![2.png](./Images/2.png)

Run the following command to get install the screpts form gmcyber github and run it and it is done turn off and take a snapshot called Base:
```
wget https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/rhel-sealer.sh
chmod +x rhel-sealer.sh
./rhel-sealer.sh
```
Before you take the snapshot remove the iso form the cd then take the snapshot:

## 7.2 DHCP Services on fw-blue1 and a static (or dynamic) route on 480-fw

on the pf sense firewall start the shell by using the option "8" and type the command below:
```
route add -net 10.0.5.0/24 10.0.17.200
netstat -r
```



































