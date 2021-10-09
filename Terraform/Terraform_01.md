# 7.1. Инфраструктура как код

#### 1.
-   Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый?
    - Скорее всего и тот и другой, т.к. предвидеться много изменний, скорее всего и в самой конфигурации серверов.
      Таким образом, предположу, что для тестовых сред стоит использовать измениемый тип инфраструктуры, для увеличения скорости доставки и тестирования сервиса,
      а для прод серверов не узменяемый тип, для гарантии корректной конфигурации.
      
-   Будет ли центральный сервер для управления инфраструктурой?   
    - Т.к. в компании уже используются Terraform и Ansible, которые не требудют центрального сервера, скорее всего центральный сервер не понадобиться, хотя это стоит уточнить.
    
-   Будут ли агенты на серверах?
    - Аналогично ответу выше.
    
-   Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?
    - Скорее всего будут использоваться и средства упарвления конфигурацией и средства инициализации ресурсов, вместе.(Terraform + Ansible + Kubernetes)
    
Из уже имеющийхся инструментов, я бы хотел использовать Terraform, Ansible, Kubernetes и Teamcity, новых инструментов не требуется.

#### 2.
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

udo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
Hit:1 https://download.docker.com/linux/ubuntu focal InRelease
Hit:2 https://baltocdn.com/helm/stable/debian all InRelease                                                                   
Hit:3 http://security.ubuntu.com/ubuntu focal-security InRelease                                                              
Hit:4 http://us.archive.ubuntu.com/ubuntu focal InRelease                                               
Hit:5 http://us.archive.ubuntu.com/ubuntu focal-updates InRelease                 
Get:6 https://apt.releases.hashicorp.com focal InRelease [4,419 B]                
Hit:7 http://us.archive.ubuntu.com/ubuntu focal-backports InRelease
Get:8 https://apt.releases.hashicorp.com focal/main amd64 Packages [33.4 kB]
Fetched 37.8 kB in 3s (14.7 kB/s)  
Reading package lists... Done

sudo apt-get update && sudo apt-get install terraform
Hit:1 http://security.ubuntu.com/ubuntu focal-security InRelease
Hit:2 http://us.archive.ubuntu.com/ubuntu focal InRelease                                                                      
Hit:3 https://baltocdn.com/helm/stable/debian all InRelease                                                                                                
Hit:4 http://us.archive.ubuntu.com/ubuntu focal-updates InRelease                                                                                          
Hit:5 https://download.docker.com/linux/ubuntu focal InRelease                                                                      
Hit:6 http://us.archive.ubuntu.com/ubuntu focal-backports InRelease               
Hit:7 https://apt.releases.hashicorp.com focal InRelease                          
Reading package lists... Done                               
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  terraform
0 upgraded, 1 newly installed, 0 to remove and 12 not upgraded.
Need to get 32.7 MB of archives.
After this operation, 79.4 MB of additional disk space will be used.
Get:1 https://apt.releases.hashicorp.com focal/main amd64 terraform amd64 1.0.8 [32.7 MB]
Fetched 32.7 MB in 5s (5,974 kB/s)    
Selecting previously unselected package terraform.
(Reading database ... 187325 files and directories currently installed.)
Preparing to unpack .../terraform_1.0.8_amd64.deb ...
Unpacking terraform (1.0.8) ...
Setting up terraform (1.0.8) ...

terraform --version
Terraform v1.0.8
on linux_amd64
```
#### 3.
```bash
snap install tfswitch
tfswitch 0.10.958 from Warren Veerasingam (warrensbox) installed

 tfswitch 
Use the arrow keys to navigate: ↓ ↑ → ← 
? Select Terraform version: 
  ▸ 1.0.8
    1.0.7
    1.0.6
    1.0.5
↓   1.0.4

./terraform -v 
Terraform v1.0.7
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.0.8. You can update by downloading from https://www.terraform.io/downloads.html

terraform -v
Terraform v1.0.8
on linux_amd64
```

