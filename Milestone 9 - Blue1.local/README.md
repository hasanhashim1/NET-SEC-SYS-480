# 480 Milestone 9 - Blue1.local

💡In this milestone you will deploy active directory domain services to our BLUE1-LAN using a combination of PowerCLI and Ansible.

### 9.1 Server Core Linked Clone### Goals
*   Use 480Utils to spin up a new  2019-server (Linked Clone from your 2019 Server Base) which will be a Domain Controller for the BLUE network (dc-blue1)
*   Create a new 480Utils Function to set a static IP configuration on the new Windows VM (dc-blue1)

### Tasks1.  
1. Use 480-utils to create a linked clone of your server 2019 core base, drop it on the BLUE-LAN and call it dc-blue1 Function should exist from prior lab
2.  Start dc-blue1 (Use Start-VM Function from prior lab)
3.  Create a new  function in 480-utils that can set a static ip of for windows systems using the Invoke-VMScript powercli function.  
4.  *   This function, in addition to guest credentials, can call an operating system command like netsh.  
    *   Set the blue1-dc's static ip to 10.0.5.5, set the netmask, gateway and name server appropriately.
    *   Tips: 
    *   *   Research the Invoke-VMScript function and see how it accepts the following parameters
        *   *   -VM
            *   -ScriptText
            *   -GuestUser  (e.g. deployer)
            *   -GuestPassword  (e.g. deployer’s password)
            *   -ScriptType
        *   Create a 480-Utils function called something like “set-windows-ip” that accepts the needed Invoke-VMSript parameter values from the 480Drive.ps1 script
        *   Do not store guest password in script.  Here are some tips for securely handling password in you 480Driver.ps1
        *   *   variable using Read-Host and -AsSecureString
            *   Then convert to a new variable (password object) using System.Net.NetworkCredential…
        *   netsh interface ip set address … and
        *   netsh interface ip set dnsservers … are helpful commands
        *   *   NOTE: you will need the interface name of the adapter on dc-blue1 - likely “Ethernet0”
         

### Resources*   
* 9.1 [Overview Video](https://drive.google.com/file/d/1djFMPoanQzeIjjKphrKkyYTW6ZAzOGH9/view?usp=sharing)
* 9.1 [Proof Demonstration](https://drive.google.com/file/d/1FV3wwdU4aVK4qj2u1A9hynCl6WeDsF1Y/view?usp=sharing)


### 9.2 ADDS Deployment
##### Goals
*   Create an Ansible Playbook to do the following on dc-blue1 to do the following
*   *   Set the local admin password
    *   Set the hostname (followed by reboot)
    *   Create a New Forest/Domain called something like BLUE.local (reboot)
    *   Create OU structure in AD

#### Tasks
*   There are multiple ways to complete this deliverable.  Researching and using current/updated ansible docs and guides will help
*   Helpful to create a windows.yml inventory file and a “servers” children group
*   *   Add needed variables
*   Here is a suggested rundown of potential tasks for the playbook
*   *   Set the Local Administrator's Password
    *   *   Do not code the password in the playbook or inventory - request during execution using “var\_prompt” with “private:yes” at start of playbook
    *   Set the hostname
    *   *   See win\_hostname:
        *   The system will need to reboot after hostname change - so can create a task using “win\_reboot:”
    *   Create a new forest using an existing ansible module and store a register  variable indicating the domain was installed
    *   *   win\_domain: 
        *   Use something like “register: domain\_install” to register the variable “domain\_install” with results of the task\
*   Another reboot is required after forest creation
*   *   Create a new task for the reboot
    *   Can specify the register variable as a condition (e.g. when:domain\_install.reboot\_required) to work with the win\_reboot: module
    *   you may have to create a pause for while dns services start up.
    *   *   Using the test\_command parameter with win\_reboot: such as         test\_command: 'exit (Get-Service -Name DNS).Status -ne "Running"'\
*   Add a DNS Server Forwarder
*   *   win\_shell:
    *   *   To call Add-DnsServerForwarder\
*   Create an OU structure (there are many ways to do this) similar to this:
*   *   blue1
    *   *   Accounts
        *   *   Groups
        *   Computers
        *   *   Servers
            *   Workstations
    *   Can create a ps1 script and call it with ansible
    *   Or can use “win\_psmodule:” with ActiveDirectoryDCS ps module and win\_dsc: in ansible**

### Resources*  
* [9.2 Overview Video](https://drive.google.com/file/d/1KKT6fJyuR3dEIVty6bsmylJY1UTOqxTb/view?usp=sharing)
* [9.2 Proof Demonstration](https://drive.google.com/file/d/19uv85_uH8rru1yxwc88yslBtmhGJtqno/view?usp=sharing)













