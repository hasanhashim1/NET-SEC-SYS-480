## Milestone 4.1 Active Directory LDAPs SSO Provider
I Install ADCS Certificate Authority via Powershell using the following command:

```
Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools
Install-AdcsCertificationAuthority -CACommonName "sean-DC1-CA" -CAType EnterpriseRootCa -CryptoProviderName "RSA#Microsoft Software Key Storage Provider" -KeyLength 2048 -credential (get-credential) -HashAlgorithmName SHA512
```

![1.png](./Images/1.png)

Now I wrote a script below and ran it to download the ADCS:
```
$c = Get-Credential
Install-AdcsCertificationAuthority -CAType EnterpriseRootCa
	-CAType EnterpriseRootCa 1
	-CACommonName dc1-Cert
	-Credential $c
	-CryptoProviderName "ECDSA_P256#Microsoft Software Key Storage Provider"
	-KeyLength 256
	-HashAlgorithmName SHA256
	-ValidityPeriod Years
	-ValidityPeriodUnits 3
```
![2.png](./Images/2.png)

fix- as shown below:

click on Yes to All and it will reboot:

![3.png](./Images/3.png)

After the reboot proces go to Certification Authority if everything works correctly you should see Hasan-DC1-CA as shown below:

![4.png](./Images/4.png)

go to vsphere, click on the menu button in the top-left-hand corner, and click on administration

![5.png](./Images/5.png)

In Administration, scroll down to **Single Sign On,** select **configuration**, and click **Active Directory Domain** and finaly click on **JOIN AD**

![6.png](./Images/6.png)

Fill the following and cick on JOIN:

![7.png](./Images/7.png)

If everything worked you should see this: 

![8.png](./Images/8.png)

Now orgnization using Organizational Unit:

*   Go back to dc1, go to server manager
*   Click on AD DS, right click on dc1, and select Active Directory Users and Computers, right click Hasan.local, click new, click Organizational Unit, name the OU "480", click ok

![9.png](./Images/9.png)
![10.png](./Images/10.png)

Do the same but inside 480 and name it Accounts:

![11.png](./Images/11.png)

do the same inside Accounts and name it ServiceAccounts:

![12.png](./Images/12.png)

Right click on **ServiceAccounts** and then click **new**, click us****er, configure it to look like the image below

![13.png](./Images/13.png)
![14.png](./Images/14.png)
![15.png](./Images/15.png)

I ran the following command in the xubunt-wan:
`openssl s_client -connect dc1.Hasan.local:636 -showcerts </dev/null 2>/dev/null | openssl x509 > cert.pem`
![16.png](./Images/16.png)
![17.png](./Images/17.png)

* in vsphere (xubunt-wan) click on the menu button in the top-left-hand corner, click **administration**
*   In **Administration**, scroll down to **Single Sign On**, select **configuration**, and click **Identity Source**, click add
      * Identity Source Type: **Active Directory over LDAP**
* Fill it out:

![18.png](./Images/18.png)

If you see this means it worked:

![19.png](./Images/19.png)

 on **Single Sign On** click on **Users and Groups** and **Groups**. Edit the **Administrators** group and add **vcenter-adm** group:
 
![20.png](./Images/20.png)

If it worked then you should be able to login as your domain as shown below:

![21.png](./Images/21.png)


## Milestone 4.2 Powershell, PowerCLI and Our First Clone
Get xubuntu-wan ready and isntall ansible as shown below:

```
sudo apt install sshpass python3-paramiko git
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible --version
```
![23.png](./Images/23.png)

don't forget to run the below commands:
```
cat >> ~/.ansible.cfg << EOF


                         
[defaults]
host_key_checking = false
EOF
```
![24.png](./Images/24.png)

Now we need to isntall powerhsell in the xubuntu to be able to clone the VMs:

```
sudo snap install powershell --classic
pwsh
Write-Host $PSVersionTable
```
![22.png](./Images/22.png)

Below are the PowerCLI libraries:
```
Install-Module VMware.PowerCLI -Scope CurrentUser
Get-Module VMware.PowerCLI -ListAvailable
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false
```
![25.png](./Images/25.png)

to connect to the system we need to use the following command:

`Connect-VIServer -Server "vcenter.hasan.local"`
`Get-Vm`

![26.png](./Images/26.png)

To manage and utilize virtual machine (VM) snapshots and storage efficiently, start by retrieving the VM named "dc1" and its "Base" snapshot using `$vm = Get-VM -Name dc1` and `$snapshot = Get-Snapshot -VM $vm -Name "Base"`. For host and datastore details, use `$vmhost = Get-VMHost -Name "192.168.7.20"` and `$ds = Get-DataStore -Name "datastore1"`. To prepare for linked clone creation, which optimizes storage by sharing disks with the parent VM, define a linked clone name with `$linkedClone = "{0}.linked" -f $vm.name`, facilitating easy identification and management of linked clones in a VMware environment.

```
$vm = Get-VM -Name dc1
$snapshot = Get-Snapshot -VM $vm -Name "Base"
$vmhost = Get-VMHost -Name "192.168.7.20"
$ds = Get-DataStore -Name "datastore1"
$linkedClone = "{0}.linked" -f $vm.name
$linkedClone
```
![27.png](./Images/27.png)

Crafting a linked clone from an existing VM snapshot using `$linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds`, which conserves resources by sharing disks. Subsequently, generate a new VM named "server.2019.gui.base" from the linked clone with `$newvm = New-VM -Name "server.2019.gui.base" -VM $linkedVM -VMHost $vmhost -Datastore $ds`, and immediately create a baseline snapshot for this new VM using `$newvm | New-Snapshot -Name "Base"`. After these operations, clean up by removing the linked VM with `$linkedvm | Remove-VM` to maintain a tidy and efficient virtual environment.

```
$linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds
$newvm = New-VM -Name "server.2019.gui.base" -VM $linkedVM -VMHost $vmhost -Datastore $ds
$newvm | New-Snapshot -Name "Base"
$linkedvm | Remove-VM
```

![28.png](./Images/28.png)

I created a script for cloning the VMs, this script started with a funcation called `cloneMyVM`. The `cloneMyVM` function streamlines the process of creating new virtual machines (VMs) from snapshots, enhancing efficiency in virtual environments. Upon invocation, it logs the source VM, snapshot used, and the name for the new VM, providing clear feedback. It leverages `Get-VM` and `Get-Snapshot` to identify the original VM and its specific snapshot, respectively, and then specifies the host and datastore. The function creates a linked clone to conserve resources and then generates a new VM with a base naming convention from this clone. Post-creation, it captures a "Base" snapshot for the new VM and cleans up by removing the temporary linked VM, ensuring a streamlined cloning process. This approach is exemplified in creating new firewall and Ubuntu VMs, demonstrating versatility and efficiency in managing virtual resources.

To access the script use the following link: https://github.com/hasanhashim1/NET-SEC-SYS-480/blob/main/cloner.ps1

Blow are the reslut after running the script:

![29.png](./Images/29.png)

in vsphere click on the menu bars in the top left-hand corner and select **inventory**. Right click on **480-DevOps-DataCenter**, select **new folder**, call it **PROD** and create another folder call it **BASEVM**:
Add the bases vms in the **BASEVM** and the rest in the **PROD**:

![30.png](./Images/30.png)
![31.png](./Images/31.png)


## Milestone 4.3 Ubuntu Server Base VM and Linked Clone
Here is the link to download the iso image of the iso image that we goin to use for this part https://old-releases.ubuntu.com/releases/22.04.1/

After downloding the iso add to the esxi datastore as shown below:

![32.png](./Images/32.png)

Now create a VM and add the iso in the CD and do the hardware configuration as shown below:

![33.png](./Images/33.png)

Now start the vm and start configureing it:

![34.png](./Images/34.png)
![35.png](./Images/35.png)

the rest of the configuration is the default so I'm not going to go over every step. setup your profile as shown below:

![36.png](./Images/36.png)

after rebooting login using the profile that you created in my case it is **depler**

![37.png](./Images/37.png)

Downloading a script to praper the vm for the base using the following command:
```
sudo -i
wget https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/ubuntu-server.sh

chmod +x ubuntu-server.sh
./ubuntu-server.sh
shutdown
```

![38.png](./Images/38.png)
![39.png](./Images/39.png)

Take a snapshot name it Base:
![40.1.png](./Images/40.1.png)
![40.png](./Images/40.png)

Now we going to use the scrept we did and make a clone of the ubuntu Base:

![42.png](./Images/42.png)

## Reflection
This milestone revolved around integrating vCenter with Active Directory (AD) for streamlined login processes, harnessing the power of PowerShell and PowerCLI on a Xubuntu-WAN environment, and masterfully extracting and cloning virtual machines (VMs) to establish a robust and efficient virtual infrastructure. The initial phase of the project involved setting up an AD Certificate Authority, a critical step that required careful attention to detail and an understanding of PowerShell commands. This foundational work was crucial for securing the communication between vCenter and the Active Directory, ensuring that only authorized users could access the system.