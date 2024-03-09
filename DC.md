## Downloading ISO and creatting the VM
we need to download the iso into the sorage of the VMware esxi:

![1.png](./Images/1.png)

Now we need create the vm as shown below:

![2.png](./Images/2.png)
Make suer that the iso is connected to the CD/DVD adapter:

![3.png](./Images/3.png)

## Settingup the server
Following the steps for setting up the server

![4.png](./Images/4.png)

Select the Desktop Experience to have gui experience:

![5.png](./Images/5.png)

![6.png](./Images/6.png)
![7.png](./Images/7.png)

When you get to a page to enter your new password for the administrator account,** do not enter a new password**, just press **Ctrl + shift + f3**, and you will be led to sysprep audit mode

![8.png](./Images/8.png)

*   Open up a PowerShell as admin and use the following command:
```
    sconfig
    5
    M
	9
```
and change the time zone to Eastern Time (US & Canada), after that check for updates:

![9.png](./Images/9.png)

Now you need to install the VMware tools:

![10.png](./Images/10.png)

In the server go to DVD and click on setup:

![11.png](./Images/11.png)

Go with setup until you see this page:

![12.png](./Images/12.png)

Now we need to use a script that was created by gmcyber, I used the following command to install the secript:
```
wget https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/windows/windows-prep.ps1 -Outfile windows-prep.ps1
notepad .\windows.ps1
```

![13.png](./Images/13.png)
![14.png](./Images/14.png)

When you opened the script in the notpad do the follwoing:
*   Remove the # from lines **7, 8, 9,** and **10** 
*   Add a # in front of lines **14** and **15**
*   Save and exit notepad

![15.png](./Images/15.png)


After that run the following command in powershell: 
```
Unblock-file .\windows.ps1
Set-ExecutionPolicy RemoteSigned
.\windows.ps1
```
![16.png](./Images/16.png)

Now after it got reboot copy 13 from the script and paste it in powershell:

![17.png](./Images/17.png)
![18.png](./Images/18.png)

when the server is powered off take out the IOS and from the CD adapter and take a snapshot:
![19.png](./Images/19.png)
![20.png](./Images/20.png)


## Domain Contorller
First we need to change the hostname (DC1) after the will restart and ask you to set a password to the administrator, to do that I ran the following command:
`Rename-Computer -NewName "DC1" -DomainCredential Domain01\deployer -Restart`

![21.png](./Images/21.png)
![22.png](./Images/22.png)

Now we need ser the ip addresses to do that do the following: go to **Netwrok & Internet Settings** → **Ethernet** → **Change adapter options** →  right click on **Ethernet0** and **Properties** → **Internet Protocol Version 4 (TCP/IPv4)** → **Properties**
![23.png](./Images/23.png)

Now add the ip addresses that were assign to you:


![24.png](./Images/24.png)

Here are the final result:

![25.png](./Images/25.png)

## ADDS 
Now we need to install the Active Directory Domain Service to do that I ran the following command:
`Add-WindowsFeature AD-Domain-Services`
![26.png](./Images/26.png)

After that I created a domain name services in my case was Hasan.local:
`Install-ADDSForest -DomainName Hasan.local -InstallDNS` after it will ask you to enter a password do so:
![27.png](./Images/27.png)

Now the system will restart and when it is on please login with your domain name that you created:

![28.png](./Images/28.png)

Now you have to create a user admin, I used the following command for that reason:
```
New-ADUser -Name Hashim-admin -AccountPassword(Read-Host -AsSecureString "InputPassword") | Enable-ADAccount
Add-ADGroupMember -Identity "Domain Admins" -Members Hasan-admin
```
I already created that user that's why you see the error in red below:

![29.png](./Images/29.png)

## DNS
Now we need to set up forward (**A** records) and reverse (**PTR** records) DNS mappings in a Windows Server environment, allowing hostnames to be resolved to IP addresses and vice versa within the specified domains. to do that I used the following commands:
```
Add-DnsServerPrimaryZone -NetworkID 10.0.17.0/24 -ZoneFile “10.0.17.4.in-addr.arpa.dns”

Add-DnsServerResourceRecordA -Name "vcenter" -ZoneName "Hasan.local" -AllowUpdateAny -IPv4Address "10.0.17.3" 
Add-DnsServerResourceRecordPtr -Name "vcenter" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "Hasan.local"

Add-DnsServerResourceRecordA -Name "480-fw" -ZoneName "Hasan.local" -AllowUpdateAny -IPv4Address "10.0.17.2" 
Add-DnsServerResourceRecordPtr -Name "480-fw" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "Hasan.local"

Add-DnsServerResourceRecordA -Name "xubuntu-wan" -ZoneName "Hasan.local" -AllowUpdateAny -IPv4Address "10.0.17.100" 
Add-DnsServerResourceRecordPtr -Name "xubuntu-wan" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "Hasan.local"

Add-DnsServerResourceRecordPtr -Name "dc1" -ZoneName "17.0.10.in-addr.arpa" -AllowUpdateAny -PtrDomainName "Hasan.local"

Get-DnsServerResourceRecord -ZoneName Hasan.local -RRType A | Format-Table
Get-DnsServerResourceRecord -ZoneName 17.0.10.in-addr.arpa -RRType PTR | Format-Table
```
![30.png](./Images/30.png)
![31.png](./Images/31.png)

## Remote Desktop and DHCP
We need to enable remote desktop to do that I did the following:
Go to **Control Panel → System and Security → System → Advanced system settings → Remote** and select the option to **Allow remote connections to this computer.** after that click on Apply and OK:

![32.png](./Images/32.png)

## Install DHCP Server Role
Now we need to install the DHCP server to do that we have to login as Administrator:

1. Open Server Manager: Click on the Start button and select Server Manager.
![33.png](./Images/33.png)
2. Add Roles and Features: In the Server Manager dashboard, click on "Add Roles and Features".

![34.png](./Images/34.png)

3. Role-based or feature-based installation: Choose "Role-based or feature-based installation" and click Next.
![35.png](./Images/35.png)
4. Select destination server: Choose the server on which you want to install the DHCP role and click Next.
![36.png](./Images/36.png)
5. Select server roles: Check the box next to "DHCP Server" in the list of roles. When prompted to add features that are required for DHCP Server, click Add Features, then click Next.
![37.png](./Images/37.png)
6. Continue through the wizard**: Proceed through the wizard, accepting default selections until you reach the "Confirm installation selections" page.
![38.png](./Images/38.png)
7. Install: Click Install. After the installation is complete, you might need to complete the DHCP Post-Install configuration wizard by defining an authorized user.
![39.png](./Images/39.png)
<!--StartFragment-->

## Authorize DHCP Server in Active Directory

1.  **Open DHCP**: From the Start Menu, open DHCP by typing "dhcp" and selecting the DHCP app.
![40.png](./Images/40.png)

2.  **Authorize DHCP Server**: In the DHCP console, right-click the server name and select "Authorize". Wait a moment, then right-click again and select "Refresh" to see the authorization status.

![41.png](./Images/41.png)
![42.png](./Images/42.png)

## Configure DHCP Scope
1.  **Open DHCP Console**: If not already open, navigate to the DHCP console as described above.

2.  **Create New Scope**: Right-click on the server name and choose "New Scope". The New Scope Wizard opens.
![43.png](./Images/43.png)
3.  **Follow the New Scope Wizard**: Enter the name ("480 Network") and description for the scope. Specify the start and end IP addresses (10.0.17.101 to 10.0.17.150) and subnet mask (255.255.255.0). Proceed through the wizard, setting up any additional options as required, like router (default gateway), domain name, and DNS servers.
![44.png](./Images/44.png)
    *   For Router (default gateway), enter `10.0.17.2`.
    *   For DNS servers, enter `10.0.17.4`.
    *   For Domain name, enter `Hasan.local`.
![45.png](./Images/45.png)


































