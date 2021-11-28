# 8.4 Работа с Roles

#### 1.
```bash
$ cat requirements.yml
---
  - src: git@github.com:netology-code/mnt-homeworks-ansible.git
    scm: git
    version: "2.0.0"
    name: elastic
```
#### 2.
```bash
$ ansible-galaxy install -r requirements.yml
Starting galaxy role install process
- extracting elastic to /home/omi/.ansible/roles/elastic
- elastic (2.0.0) was installed successfully
```
#### 3.
```bash
$ ansible-galaxy init kibana-role
- Role kibana-role was created successfully
```

#### 4.
```bash
$ cat vars/main.yml ; cat defaults/main.yml
---
elk_stack_version: "7.15.2"
---
elk_stack_version: "7.15.2"

$ cat tasks/main.yml ; cat handlers/main.yml
---
 - name: "Download kibana rpm"
 ¦ get_url:
 ¦ ┆ url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ elk_stack_version }}-x86_64.rpm"
 ¦ ┆ dest: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
 ¦ register: kibana_download
 ¦ until: kibana_download is succeeded
 - name: "Install kibana"
 ¦ become: true
 ¦ yum:
 ¦ ┆ name: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
 ¦ ┆ state: present
 - name: "Configure kibana"
 ¦ become: true
 ¦ template:
 ¦ ┆ src: kibana.yaml.j2
 ¦ ┆ dest: "/etc/kibana/kibana.yml"
 ¦ ┆ mode: 0755
 ¦ notify: restart Kibana
---
 - name: restart Kibana
 ¦ become: true
 ¦ service:
 ¦ ┆ name: kibana
 ¦ ┆ state: restarted
```
#### 5.
```bash
$ ls templates/
kibana.yaml.j2
```
#### 6.
```bash
$ ansible-galaxy init filebeat-role --force
- Role filebeat-role was created successfully
```
#### 7.
```bash
$ cat tasks/main.yml ; cat handlers/main.yml ; cat vars/main.yml ; cat defaults/main.yml
---
  - name: "Download filebeat"
  ¦ get_url:
  ¦ ┆ url: "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-{{ elk_stack_version }}-x86_64.rpm"
  ¦ ┆ dest: "/tmp/filebeat-{{ elk_stack_version }}-x86_64.rpm"
  ¦ ┆ mode: 0755
  ¦ register: filebeat_download
  ¦ until: filebeat_download is succeeded
  - name: "Install filebeat"
  ¦ become: true
  ¦ yum:
  ¦ ┆ name: "/tmp/filebeat-{{ elk_stack_version }}-x86_64.rpm"
  ¦ ┆ state: present
  - name: "Configure filebeat"
  ¦ become: true
  ¦ template:
  ¦ ┆ src: "templates/filebeat.yml.j2"
  ¦ ┆ dest: "/etc/filebeat/filebeat.yml"
  ¦ ┆ mode: 0755
  ¦ notify: restart filebeat# tasks file for filebeat-role
---
  - name: restart filebeat
  ¦ become: true
  ¦ service:
  ¦ ┆ name: filebeat
  ¦ ┆ state: restarted
---
elk_stack_version: "7.15.2"
---
elk_stack_version: "7.15.2"
```
#### 8.
```bash
$ ls templates/
filebeat.yml.j2
```
#### 10.
https://github.com/OmegaM/kibana-role
https://github.com/OmegaM/filebeat-role
#### 11.
```bash
 cat requirements.yml
---
  - src: git@github.com:netology-code/mnt-homeworks-ansible.git
    scm: git
    version: 2.0.0
    name: elastic
  - src: git@github.com:OmegaM/kibana-role.git
    scm: git
    name: kibana
    version: 0.0.1
  - src: git@github.com:OmegaM/filebeat-role.git
    scm: git
    name: filebeat
    version: 0.0.1
```
#### 12.
```bash
$ cat site.yml
---
  - name: Install and configure Elasticsearch
    hosts: elasticsearch
    roles:
      - elastic
  - name: Install and configure Kibana
    hosts: kibana
    roles:
      - kibana
  - name: Install and configure fileabeat
    hosts: filebeat
    roles:
      - filebeat
```