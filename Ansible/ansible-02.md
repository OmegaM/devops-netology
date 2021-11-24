# 08.02 Работа с Playbook.

#### 1.
```bash
$ cat inventory/prod.yml
---
elasticsearch:
  hosts:
    localhost:
      ansible_connection: docker
kibana:
  hosts:
    kibana_host:
      ansible_connection: docker
```
#### 2.
```bash
$ cat site.yml
---
- name: Install Java
  hosts: all
  tasks:
    - name: Set facts for Java 11 vars
      set_fact:
        java_home: "/opt/jdk/{{ java_jdk_version }}"
      tags: java
    - name: Upload .tar.gz file containing binaries from local storage
      copy:
        src: "{{ java_oracle_jdk_package }}"
        dest: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
        mode: 0755
      register: download_java_binaries
      until: download_java_binaries is succeeded
      tags: java
    - name: Ensure installation dir exists
      become: true
      file:
        state: directory
        path: "{{ java_home }}"
        mode: 0755
      tags: java
    - name: Extract java in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
        dest: "{{ java_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ java_home }}/bin/java"
      tags:
        - java
    - name: Export environment variables
      become: true
      template:
        src: jdk.sh.j2
        dest: /etc/profile.d/jdk.sh
        mode: 0755
      tags: java
- name: Install Elasticsearch
  hosts: elasticsearch
  tasks:
    - name: Upload tar.gz Elasticsearch from remote URL
      get_url:
        url: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
        dest: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: get_elastic
      until: get_elastic is succeeded
      tags: elastic
    - name: Create directrory for Elasticsearch
      file:
        state: directory
        path: "{{ elastic_home }}"
        mode: 0755
      tags: elastic
    - name: Extract Elasticsearch in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
        dest: "{{ elastic_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ elastic_home }}/bin/elasticsearch"
        mode: 0755
      tags:
        - elastic
    - name: Set environment Elastic
      become: true
      template:
        src: templates/elk.sh.j2
        dest: /etc/profile.d/elk.sh
        mode: 0755
      tags: elastic
- name: Install Kibana
  hosts: kibana
  tasks:
    - name: Download Kibana from URL
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "/tmp/"
        mode: 0755
      tags: kibana
    - name: Create direcrory for kibana
      file:
        state: directory
        path: "{{ kibana_home }}"
        mode: 0755
      tags: kibana
    - name: Extract Kibana
      become: true
      unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
      tags: kibana
    - name: Prepare kibana config
      become: true
      template:
        src: templates/kibana.yml.j2
        dest: "{{ kibana_home }}/config/kibana.yml"
        mode: 0755
      tags: kibana
    - name: Start Kibana
      become: true
      command:
        cmd: "{{ kibana_home }}/bin/kibana --allow-root &"
      changed_when: false
```

#### 5.
```bash
$ ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```

#### 6.
```
$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Java] *********************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host kibana_host should use /usr/bin/python3, but is using /usr/bin/python for backward
compatibility with prior Ansible releases. A future Ansible release will default to using the discovered platform python for this host. See
https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed in
version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [kibana_host]
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host localhost should use /usr/bin/python3, but is using /usr/bin/python for backward
compatibility with prior Ansible releases. A future Ansible release will default to using the discovered platform python for this host. See
https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed in
version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [localhost]

TASK [Set facts for Java 11 vars] *******************************************************************************************************************
ok: [localhost]
ok: [kibana_host]

TASK [Upload .tar.gz file containing binaries from local storage] ***********************************************************************************
ok: [localhost]
ok: [kibana_host]

TASK [Ensure installation dir exists] ***************************************************************************************************************
ok: [localhost]
ok: [kibana_host]

TASK [Extract java in the installation directory] ***************************************************************************************************
skipping: [localhost]
skipping: [kibana_host]

TASK [Export environment variables] *****************************************************************************************************************
ok: [localhost]
ok: [kibana_host]

PLAY [Install Elasticsearch] ************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [localhost]

TASK [Upload tar.gz Elasticsearch from remote URL] **************************************************************************************************
changed: [localhost]

TASK [Create directrory for Elasticsearch] **********************************************************************************************************
ok: [localhost]

TASK [Extract Elasticsearch in the installation directory] ******************************************************************************************
skipping: [localhost]

TASK [Set environment Elastic] **********************************************************************************************************************
ok: [localhost]

PLAY [Install Kibana] *******************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************
ok: [kibana_host]

TASK [Download Kibana from URL] *********************************************************************************************************************
changed: [kibana_host]

TASK [Create direcrory for kibana] ******************************************************************************************************************
ok: [kibana_host]

TASK [Extract Kibana] *******************************************************************************************************************************
skipping: [kibana_host]

TASK [Prepare kibana config] ************************************************************************************************************************
ok: [kibana_host]

TASK [Start Kibana] *********************************************************************************************************************************
skipping: [kibana_host]

PLAY RECAP ******************************************************************************************************************************************
kibana_host                : ok=9    changed=1    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
localhost                  : ok=9    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```
#### 7.
```bash
...
TASK [Prepare kibana config] ************************************************************************************************************************
--- before: /opt/kibana-7.15.2/config/kibana.yml
+++ after: /home/omi/.ansible/tmp/ansible-local-53140h6blgdp6/tmpals12y35/kibana.yml.j2
@@ -1,35 +1,6 @@
-# Kibana is served by a back end server. This setting specifies the port to use.
-#server.port: 5601
-
-# Specifies the address to which the Kibana server will bind. IP addresses and host names are both valid values.
-# The default is 'localhost', which usually means remote machines will not be able to connect.
-# To allow connections from remote users, set this parameter to a non-loopback address.
-#server.host: "localhost"
-
-# Enables you to specify a path to mount Kibana at if you are running behind a proxy.
-# Use the `server.rewriteBasePath` setting to tell Kibana if it should remove the basePath
-# from requests it receives, and to prevent a deprecation warning at startup.
-# This setting cannot end in a slash.
-#server.basePath: ""
-
-# Specifies whether Kibana should rewrite requests that are prefixed with
-# `server.basePath` or require that they are rewritten by your reverse proxy.
-# This setting was effectively always `false` before Kibana 6.3 and will
-# default to `true` starting in Kibana 7.0.
-#server.rewriteBasePath: false
-
-# Specifies the public URL at which Kibana is available for end users. If
-# `server.basePath` is configured this URL should end with the same basePath.
-#server.publicBaseUrl: ""
-
-# The maximum payload size in bytes for incoming server requests.
-#server.maxPayload: 1048576
-
-# The Kibana server's name.  This is used for display purposes.
-#server.name: "your-hostname"
-
-# The URLs of the Elasticsearch instances to use for all your queries.
-#elasticsearch.hosts: ["http://localhost:9200"]
+server.port: 5601
+server.host: "0.0.0.0"
+elasticsearch.hosts: ["http://localhost:9200"]

 # Kibana uses an index in Elasticsearch to store saved searches, visualizations and
 # dashboards. Kibana creates a new index if the index doesn't already exist.

changed: [kibana_host]
...
```