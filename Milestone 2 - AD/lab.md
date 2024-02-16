## Resources
*   [Network Diagram](https://drive.google.com/file/d/1Fiqjkma-3v9IrhAPJH5qigvboe8xZZo6/view?usp=sharing)
*   [Windows Sysprep Demo](https://drive.google.com/file/d/1Vi1lqm2gzWTyWyYnkAfKW7Rsj3C7-lWE/view?usp=sharing)
*   [Milestone 2 - Proof](https://drive.google.com/file/d/1909z95Y5B2B4SbZ2PUw-BJgkSmVTxbFP/view?usp=sharing)
 
## Requirements
The rough steps you will take, document and test include:*   Create a sysprepped windows server 19 baseline.
*   *   Follow the demo!
    *   Rough steps below:\
*   Installing Win Server 2019:
*   *   Pull ISO to your datastore on ESXI
    *   *   ISOs: \\\rackstation2\CYBER-SHARE\ISOs\SP24\480
    *   Create new VM - 4gb RAM, 90gb HDD, Network adapter on VMNet for now
    *   *   SELECT THIN PROVISION!
        *   4gb sounds low, but we will be mostly just interfacing via SSH after install, you can always change later on if it gets laggy
    *   Standard - Desktop Experience
    *   *   You can do Core if you are confident though 🙂
    *   DON'T SET THE ADMIN PASSWORD
    *   *   On that screen, use CTRL+SHIFT+F3 to enter audit mode
        *   Do NOT touch the open dialogue until finished sysprepping
    *   Open Powershell, enter ‘sconfig’
    *   *   Select 5: Change to manual windows updates
        *   Select 9: Change timezone to Eastern
        *   Select 6: Install updates - ALL
        *   *   This is going to take multiple reboots, continue rebooting, searching for more updates and installing until no more updates are found!
            *   *   This may take up to an hour! Go get some coffee and clean up Tech Journals\
*   Install VMware tools
*   *   Right click in host console, guest OS - install vmware tools, this mounts to VM, then run in OS
*   After you have installed all updates, VMWare tools, and restarted, then pull down the following Sysprep script: Sysprep script link: <https://tinyurl.com/480sysprep> 
*   *   Use wget to download the file and then edit it BEFORE running!
    *   *   Edits to script:
        *   *   Comment last 2 lines
            *   Uncomment all lines pertaining to creating the deployer user
            *   Double check demo vid to make sure you’ve got the right lines
    *   You’ll have to unblock the file and change execution policy to be able to run!
*   After you run the script, reboot and the script will have run up until the last uncommented line. There will be a pop-up about ‘Sysprep tool is already running’. Now reboot again. You will need to run the sysprep command (last uncommented line) manually”
*   *   Next, manually copy that final line into powershell and run it
    *   (the one that runs sysprep and references the downloaded unattend.xml)
*   Finally, shut down and remove the CD/ISO from the VM in VM settings in ESXI
*   Make sure you’re VM is powered off and take a snapshot, name it ‘Base’\
You’re done! You now have a clean snapshot of a Windows Server 19 we will use in future labs. You will also continue to use the VM now to set up your DC1, but having that clean snapshot is crucial, especially for future deployment/provisioning labs. Hold on to that clean snapshot, but moving forward we will continue with this VM as normal for setting up AD.\
For this part, there is no demo, and I won’t outline the steps other than basic deliverables. You are expected to do the AD setup remotely from your Xubuntu management box via powershell commands and document all of them!\
*   Using your new baseline (make sure you have that Base snapshot), start it up and
*   *   Add the Administrative user password
    *   Change the segment to 480-WAN give it an ip of 10.0.17.4/24 and a hostname of dc1, you will want DNS and Gateway pointing to vyos:10.0.17.2 initially
    *   Do remember to rename the computer before installing the forest if you didn't set it already.
    *   Complete configuration using powershell/ssh from xubuntu-wan as deployer
    *   *   Document all commands in your tech journal!
    *   install adds (yourname.local)
    *   install dns
    *   *   create A and PTR entries for 
        *   *   vcenter.yourname.local at 10.0.17.3
            *   480-fw as 10.0.17.2
            *   xubuntu-wan at 10.0.17.100
            *   dc1 (just PTR needs to be added) at 10.0.17.4
    *   enable remote desktop via powershell
    *   install dhcp services
    *   *   this is a good [reference](https://medium.com/@droidmlwr/install-ad-ds-dns-and-dhcp-using-powershell-on-windows-server-2016-ac331e5988a7)
        *   create a dhcp scope from 10.0.17.101-150
        *   router should be 10.0.17.2
        *   dns server should be 10.0.17.4
    *   make sure to create a named domain admin (yourname-adm.yourlastname.local)**

