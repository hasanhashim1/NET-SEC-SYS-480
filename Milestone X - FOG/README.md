# Milestone X - FOG
Note: This is an older lab we are bringing back this time around that used to be implemented after Milestone 4. Since we finished with a strong pace, I’m bringing this lab back towards the end to ease the landing towards the end. This should be pretty easy for you compared to recent labs, and also only has pre-req of Milestone 4.

#### Prerequisites
*   You've finished Milestone 4 Tasks
##### IMPORTANT NOTE: 
Before starting, it might be a good idea to go back and review Milestone 4. Towards the start of video 5.1, Devin will recall creating a CentOS base image and naming it “fog”. Due to some aspects of the course changing, this was slightly different from your experience in Milestone 4, but you will still have all the tools you need. Instead of a CentOS base image called “Fog” you will need a Rocky base image called “Rocky Base”.
Be mindful of your Super datastore space remaining, remove old milestone VMs if needed, but do so carefully please…

#### Prep
*   Download a Rocky 8 minimal ISO from here: <https://rockylinux.org/download/>
*   Create a new VM, 2 CPU, 2GB RAM, and add a 2nd hard disk drive in the VM options \*(this disk is important for this milestone!)
*   *   The demo video will mention this 2nd disk creation happening in Milestone 4, again, we are not using a base from M4, we are creating a new one now.
*   Install OpenSSH Server, disable IPv6
*   Use prep script from M4 \*(prep script is an Ubuntu sealer, with Rocky there may be some things that are different, like the package manager for example, I’ll leave this to you to adjust!)
*   Power down, detach ISO, snapshot for FOG Base
*   Using your PowerCLI scripts and TechJournal you built for Milestones 4.2 & 4.3, create a new linked clone from your Rocky Base and name it “FOG”

#### Fog Installation Tasks
*   \*Note: As explained above, their may be some discrepancies in the video
*   [Video 5.1](https://drive.google.com/file/d/1SvKK7z8B4tnCm7jNgKElpEuBAKsFXp61/view?usp=sharing)
*   create a fog sudo user
*   name the host (fog)
*   static IP of 10.0.17.5 (can use another if this is taken in your environment)
*   Add A and PTR records for your fog server
*   Configure the second disk (see demo)
*   Adjust SELinux - permissive or off, and allow FOG needed services through firewall
*   Install FOG (this may take some time, fog installer is slow, be patient!)


##### Image Capture Tasks
* [Video 5.2](https://drive.google.com/file/d/1iL0guYnOPxmIChsfxkMSZIFyU02XcxWC/view?usp=sharing)
*   *   \*From ~3m - Xm of the video, Devin will overview some PowerCLI basics, we’ve already done this so you can skip around as needed after the first 3 minutes
    *   \*~18:25m in the video, Devin powers off too early when capturing, don’t make this mistake if you’re following step-by-step!
    *   \*At the end, Devin notes that we will do this with another OS (other than xubuntu), that’s not the case, do this lab with xubuntu as the capture target and deployed OS.
*   Configure options 66 & 67 for DHCP on your DC1 (not your Blue DC, remember this was originally done before any of the Blue network was created)
*   From your xubuntu base image, Create a linked image of xubuntu-base called xubuntu-capture-target
*   Deploy your image to xubuntu-deploy


