## Milestone 4.1 Active Directory LDAPs SSO Provider
![1.png](./Images/1.png)
![2.png](./Images/2.png)
![3.png](./Images/3.png)
![4.png](./Images/4.png)
![5.png](./Images/5.png)
![6.png](./Images/6.png)
![7.png](./Images/7.png)
![8.png](./Images/8.png)
![9.png](./Images/9.png)
![10.png](./Images/10.png)
![11.png](./Images/11.png)
![12.png](./Images/12.png)
![13.png](./Images/13.png)
![14.png](./Images/14.png)
![15.png](./Images/15.png)
![16.png](./Images/16.png)
![17.png](./Images/17.png)
![18.png](./Images/18.png)
![19.png](./Images/19.png)
![20.png](./Images/20.png)
![21.png](./Images/21.png)


## Milestone 4.2 Powershell, PowerCLI and Our First Clone
```
sudo apt install sshpass python3-paramiko git
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible --version
```
![23.png](./Images/23.png)
```
cat >> ~/.ansible.cfg << EOF


                         
[defaults]
host_key_checking = false
EOF
```
![24.png](./Images/24.png)

```
sudo snap install powershell --classic
pwsh
Write-Host $PSVersionTable
```
![22.png](./Images/22.png)

```
Install-Module VMware.PowerCLI -Scope CurrentUser
Get-Module VMware.PowerCLI -ListAvailable
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false
```
![25.png](./Images/25.png)

`Connect-VIServer -Server "vcenter.hasan.local"`
`Get-Vm`

![26.png](./Images/26.png)



## Milestone 4.3 Ubuntu Server Base VM and Linked Clone

still working on it






















