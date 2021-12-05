# 08.03 Использование Yandex Cloud

#### 1.
```bash
cat site.yml
---
- name: Install Elasticsearch
  hosts: elasticsearch
  handlers:
    - name: restart Elasticsearch
      become: true
      service:
        name: elasticsearch
        state: restarted
  tasks:
    - name: "Download Elasticsearch's rpm"
      get_url:
        url: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-{{ elk_stack_version }}-x86_64.rpm"
        dest: "/tmp/elasticsearch-{{ elk_stack_version }}-x86_64.rpm"
      register: download_elastic
      until: download_elastic is succeeded
    - name: Install Elasticsearch
      become: true
      yum:
        name: "/tmp/elasticsearch-{{ elk_stack_version }}-x86_64.rpm"
        state: present
    - name: Configure Elasticsearch
      become: true
      template:
        src: elasticsearch.yml.j2
        dest: /etc/elasticsearch/elasticsearch.yml
      notify: restart Elasticsearch
- name: Install Kibana
  hosts: kibana
  handlers:
    - name: restart Kibana
      become: true
      service:
        name: kibana
        state: restarted
  tasks:
    - name: "Download kibana rpm"
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ elk_stack_version }}-x86_64.rpm"
        dest: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
      register: kibana_download
      until: kibana_download is succeeded
    - name: "Install kibana"
      become: true
      yum:
        name: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
        state: present
    - name: "Configure kibana"
      become: true
      template:
        src: kibana.yaml.j2
        dest: "/etc/kibana/kibana.yml"
      notify: restart Kibana
```

#### 4.
```bash
$ cat inventory/prod/hosts.yml
---
all:
  hosts:
    el-instance:
      ansible_host: 51.250.11.50
    k-instance:
      ansible_host: 51.250.10.173
  vars:
    ansible_connection: ssh
    ansible_user: omi
elasticsearch:
  hosts:
    el-instance:
kibana:
  hosts:
    k-instance:
```
#### 5.
```bash
$ ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```
#### 6.
```bash
$ ansible-playbook -i inventory/prod/ site.yml --check

PLAY [Install Elasticsearch] ************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [el-instance]

TASK [Download Elasticsearch's rpm] *****************************************************************************************************************
ok: [el-instance]

TASK [Install Elasticsearch] ************************************************************************************************************************
ok: [el-instance]

TASK [Configure Elasticsearch] **********************************************************************************************************************
changed: [el-instance]

RUNNING HANDLER [restart Elasticsearch] *************************************************************************************************************
changed: [el-instance]

PLAY [Install Kibana] *******************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [k-instance]

TASK [Download kibana rpm] **************************************************************************************************************************
ok: [k-instance]

TASK [Install kibana] *******************************************************************************************************************************
ok: [k-instance]

TASK [Configure kibana] *****************************************************************************************************************************
changed: [k-instance]

RUNNING HANDLER [restart Kibana] ********************************************************************************************************************
changed: [k-instance]

PLAY [Install filebeat] *****************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [f-instance]

TASK [Download filebeat] ****************************************************************************************************************************
ok: [f-instance]

TASK [Install filebeat] *****************************************************************************************************************************
ok: [f-instance]

TASK [Configure filebeat] ***************************************************************************************************************************
changed: [f-instance]

RUNNING HANDLER [restart filebeat] ******************************************************************************************************************
changed: [f-instance]

PLAY RECAP ******************************************************************************************************************************************
el-instance                : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
f-instance                 : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
k-instance                 : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
#### 7.
```bash
...
TASK [Configure Elasticsearch] **********************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
-    "mode": "0660",
+    "mode": "0755",
     "path": "/etc/elasticsearch/elasticsearch.yml"
 }

changed: [el-instance]
...
TASK [Configure kibana] *****************************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
-    "mode": "0660",
+    "mode": "0755",
     "path": "/etc/kibana/kibana.yml"
 }

changed: [k-instance]
...
RUNNING HANDLER [restart filebeat] ******************************************************************************************************************
changed: [f-instance]
```
