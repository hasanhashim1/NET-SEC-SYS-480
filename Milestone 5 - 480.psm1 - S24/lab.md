# Milestone 5: 480-Utils.psm1 - S23

## Overview

In a previous milestone, we installed PowerShell and PowerCLI and accessed vSphere both interactively and through a `.ps1` script. This module focuses on creating a PowerShell module, which we will continue to develop throughout the semester.

PowerShell/PowerCLI is utilized for deploying and configuring virtual machines (VMs) and their hardware, leveraging VMWare Tools guest integration for enhanced functionalities.

## Resources

- Milestone Overview
- The 480.psm1 Module
- The proof video

## Requirements for Milestone 5

- License vCenter and vSphere/ESXi using provided instructions.
- Install Visual Studio Code (VSCode) on Xubuntu-WAN along with the PowerShell extension.
- Build a module skeleton as described in the provided resource.
- Improve upon or implement functions demonstrated in previous milestones.
- Add functions to your `480Utils.psm1` module to:
  - Create a linked or full clone.
  - Gather parameters interactively or via a configuration file.
  - Handle errors gracefully.

### Optional Features for Extra Credit

- Set the new VM's network adapters to a specified network.
- Power on the VM after creation.
- Include any other functionalities discovered during development.

## Deliverables

- A proof video demonstrating the module in action within your own environment.
- A code review of functions you've authored, presented via GitHub source browsing.
- A walkthrough of any technical journal entries made during this milestone.

## Academic Integrity

This project must be your own work. While general discussion and troubleshooting are encouraged, direct code sharing is prohibited. Credit any external sources or helpful peers appropriately in both your code and documentation.

## Useful PowerShell and PowerCLI Functions

- `Read-Host`
- `Write-Host`
- `Connect-VIServer`
- `Get-Folder`
- `Get-VM`
- `Get-Snapshot`
- `Get-Datastore`
- `New-VM`
- `Remove-VM` (use with caution)

## Proof Check Rubric

- Ensure licensing for vCenter and vSphere is valid.
- Demonstrate creation of a linked clone.
- Show and explain your code.

*Updated Feb 7, 2023*
