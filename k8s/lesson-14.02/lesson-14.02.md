# 14.2 Синхронизация секретов с внешними сервисами. Vault

#### 1. 
```bash
 k apply -f vault-pod.yml                                                                                                                                            ─╯
pod/14.2-netology-vault created

k get po                                                                                                                                                            ─╯
NAME                  READY   STATUS    RESTARTS   AGE
14.2-netology-vault   1/1     Running   0          29s

k get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'                                                                                                      ─╯
[{"ip":"172.17.0.2"}]

k run -i --tty fedora --image=fedora --restart=Never -- sh                                                                                                          ─╯
If you don't see a command prompt, try pressing enter.
sh-5.1#  dnf -y install pip
Fedora 36 - x86_64
....
Installed:
  libxcrypt-compat-4.4.28-1.fc36.x86_64                    python3-pip-21.3.1-2.fc36.noarch                    python3-setuptools-59.6.0-2.fc36.noarch

Complete!

sh-5.1# pip install hvac
Collecting hvac
....
Installing collected packages: urllib3, idna, charset-normalizer, certifi, six, requests, hvac
Successfully installed certifi-2022.5.18.1 charset-normalizer-2.0.12 hvac-0.11.2 idna-3.3 requests-2.27.1 six-1.16.0 urllib3-1.26.9

sh-5.1# python3
Python 3.10.4 (main, Mar 25 2022, 00:00:00) [GCC 12.0.1 20220308 (Red Hat 12.0.1-0)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import hvac
>>> client = hvac.Client(
...      url='http://172.17.0.2:8200',
...      token='aiphohTaa0eeHei'
... )
>>> client.is_authenticated()
True
>>>
>>> client.secrets.kv.v2.create_or_update_secret(
...     path='hvac',
...     secret=dict(netology='Big secret!!!'),
... )
{'request_id': '6376a628-39ad-857d-68a5-cd5c90150f96', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'created_time': '2022-05-29T08:56:06.2018931Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 2}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>>
>>> client.secrets.kv.v2.read_secret_version(
...     path='hvac',
... )
{'request_id': '9d5642ce-f63a-4f09-5ed6-07f9efbbadef', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'data': {'netology': 'Big secret!!!'}, 'metadata': {'created_time': '2022-05-29T08:56:06.2018931Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 2}}, 'wrap_info': None, 'warnings': None, 'auth': None}
```

