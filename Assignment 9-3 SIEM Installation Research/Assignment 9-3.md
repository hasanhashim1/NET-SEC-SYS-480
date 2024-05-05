# SIEM Installation Research
For my upcoming Milestone Project, titled "Milestone 8 - Putting the SEC in DevOps," I have chosen to use Wazuh as the Security Information and Event Management (SIEM) system. Here is the preparation and planning document outlining the selection process, installation guides, and installation steps for both the Wazuh server and agent on a Rocky Linux environment.

### SIEM Selection: Wazuh

After considering various SIEM options such as Splunk, Graylog, ELK Stack, Velociraptor, and FleetDM, I have decided to proceed with Wazuh for its open-source nature, robust features, and strong community support. It is particularly well-suited for integration with Ansible, which will help in automating the deployment across my network.

### Installation Documentation Research

I focused on finding the most accurate and recent installation documentation for Wazuh compatible with Rocky Linux. I consulted several sources including the official Wazuh documentation, community forums, and GitHub repositories. My criteria for selecting the documentation were based on the relevance to Rocky Linux, the recency of the guides, and the consistency across various sources.

### Installation Guides

#### Server Installation on Rocky Linux

1.  **Preparation**:

    *   Install necessary dependencies:
```
Copy code
sudo dnf install wget vim git
```
*   Set up the Wazuh repository:
```
bash
Copy code
sudo rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH
echo -e '[wazuh]\nname=Wazuh repository\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH\nbaseurl=https://packages.wazuh.com/4.x/yum/' | sudo tee /etc/yum.repos.d/wazuh.repo
```
2.  **Installation**:

    *   Install the Wazuh manager:
```
Copy code
sudo dnf install wazuh-manager
```
3.  **Configuration**:

    *   Edit the configuration file to ensure proper network settings and agent management.

#### Agent Installation on a BLUE-LAN System

1.  **Preparation**:

    *   Repeat the repository setup steps from the server installation.

2.  **Installation**:

    *   Install the Wazuh agent:
```
Copy code
sudo dnf install wazuh-agent
```
3.  **Configuration**:

    *   Configure the agent to connect to the Wazuh manager by specifying the manager’s IP in the agent configuration file.

### Deliverables

*   **Chosen SIEM**: Wazuh on Rocky Linux for both the server and agent.

*   **Installation Guides**: Utilized the following guides from Wazuh's official documentation:

    *   [Server Installation Guide 1](https://documentation.wazuh.com/current/installation-guide/wazuh-server/step-by-step.html)
    *   [Server Installation Guide 2](https://documentation.wazuh.com/current/installation-guide/wazuh-server/installation-assistant.html)
    *   [Agent Installation Guide 1](https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-windows.html)
    *   [Agent Installation Guide 2](https://documentation.wazuh.com/current/installation-guide/wazuh-agent/index.html)

*   **Outlined Installation Steps**: Detailed above for both the server and agent installations.
