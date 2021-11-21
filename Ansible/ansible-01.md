# 08.01 Введение в Ansible

#### 1. 
```bash
ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] ********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [localhost]

TASK [Print OS] **************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *******************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

#### 2.
```bash
$ cat  group_vars/all/examp.yml
---
  some_fact: 12

$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] ********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [localhost]

TASK [Print OS] **************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *******************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
#### 3.
```bash
docker run --rm --name ubuntu ubuntu sleep 999999 & docker run --name centos --rm centos sleep 999999 &
```
#### 4.
```bash
 ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [ubuntu]
ok: [centos]

TASK [Print OS] **************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************
ok: [centos] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP *******************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

#### 5.
```bash
$  cat group_vars/el/examp.yml
---
  some_fact: "el {{ default_fact}}"

$ cat group_vars/deb/examp.yml
---
  some_fact: "deb {{ default_fact }}"

$ cat group_vars/all/examp.yml
---
  default_fact: "dafault fact"
  some_fact: "all {{ default_fact }}"

```
#### 6.
```bash
 ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [ubuntu]
ok: [centos]

TASK [Print OS] **************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************************
ok: [centos] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *******************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

#### 7.
```bash
$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful

$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
```

#### 8.
```bash
 ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password:

PLAY [Print os facts] **********************************************************************************************

TASK [Gathering Facts] *********************************************************************************************
ok: [ubuntu]
ok: [centos]

TASK [Print OS] ****************************************************************************************************
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************
ok: [centos] => {
    "msg": "el dafault fact"
}
ok: [ubuntu] => {
    "msg": "deb dafault fact"
}

PLAY RECAP *********************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

#### 9.
```bash
$ ansible-doc -t connection -l

ansible.netcommon.httpapi      Use httpapi to run command on network appliances
ansible.netcommon.libssh       (Tech preview) Run tasks using libssh for ssh connection
ansible.netcommon.napalm       Provides persistent connection using NAPALM
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol
ansible.netcommon.network_cli  Use network_cli to run command on network appliances
ansible.netcommon.persistent   Use a persistent unix socket for connection
community.aws.aws_ssm          execute via AWS Systems Manager
community.docker.docker        Run tasks in docker containers
community.docker.docker_api    Run tasks in docker containers
community.docker.nsenter       execute on host running controller container
community.general.chroot       Interact with local chroot
community.general.funcd        Use funcd to connect to target
community.general.iocage       Run tasks in iocage jails
community.general.jail         Run tasks in jails
community.general.lxc          Run tasks in lxc containers via lxc python library
community.general.lxd          Run tasks in lxc containers via lxc CLI
community.general.qubes        Interact with an existing QubesOS AppVM
community.general.saltstack    Allow ansible to piggyback on salt minions
community.general.zone         Run tasks in a zone instance
community.kubernetes.kubectl   Execute tasks in pods running on Kubernetes
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines
community.okd.oc               Execute tasks in pods running on OpenShift
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools
containers.podman.buildah      Interact with an existing buildah container
containers.podman.podman       Interact with an existing podman container
kubernetes.core.kubectl        Execute tasks in pods running on Kubernetes
local                          execute on controller
paramiko_ssh                   Run tasks via python ssh (paramiko)
psrp                           Run tasks over Microsoft PowerShell Remoting Protocol
ssh                            connect via ssh client binary
winrm                          Run tasks over Microsoft's WinRM
```
#### 10.
```bash
$ cat inventory/prod.yml
---
  el:
    hosts:
      centos:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker

  local:
    hosts:
      localhost:
        ansible_connection: local
```
#### 11.
```bash
$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password:

PLAY [Print os facts] **********************************************************************************************

TASK [Gathering Facts] *********************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos]

TASK [Print OS] ****************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************
ok: [localhost] => {
    "msg": "all dafault fact"
}
ok: [centos] => {
    "msg": "el dafault fact"
}
ok: [ubuntu] => {
    "msg": "deb dafault fact"
}

PLAY RECAP *********************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

#### *1.
```bash
$ ansible-vault decrypt group_vars/el/examp.yml
Vault password:
Decryption successful
$ ansible-vault decrypt group_vars/deb/examp.yml
Vault password:
Decryption successful
```

#### *2.
```bash
$ ansible-vault encrypt_string 'PaSSw0rd' --name 'some_fact'
New Vault password:
Confirm New Vault password:
some_fact: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          36366232376165633466376662393135636564666566373235303333313636346334333764316230
          3565643639623239383363366431383737666365336439620a313339396231653638353830373661
          37366533303832343335383035633838663230656335613762666238303031383362633965663636
          3635386237306666610a363830366662333732333463313639393437646537363838646335613038
          6331
Encryption successful
```

#### *3.
```bash
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password:

PLAY [Print os facts] **********************************************************************************************

TASK [Gathering Facts] *********************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos]

TASK [Print OS] ****************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [centos] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [centos] => {
    "msg": "el dafault fact"
}
ok: [ubuntu] => {
    "msg": "deb dafault fact"
}

PLAY RECAP *********************************************************************************************************
centos                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
#### *4.
```bash
cat inventory/prod.yml
---
  el:
    hosts:
      centos:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker

  local:
    hosts:
      localhost:
        ansible_connection: local

  fed:
    hosts:
      fedora:
        ansible_connection: docker
```

#### *5.
```bash
#!/bin/bash

hosts=($(ansible all --list-host -i playbook/inventory/prod.yml))
for host in ${hosts[@]:1}
do
        name=$host
        if [[ $name == 'localhost' ]] ; then
                continue
        fi
        if [[ $host == "centos" ]] ; then
                host='centos:7'
        fi
        docker run --rm --name $name "pycontribs/$host" sleep 99999 &
done

ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --vault-password-file ./secret

docker stop $(docker ps -aq)
```