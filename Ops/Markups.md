# 4.3. Языки разметки JSON и YAML

#### 1.
```json
{ "info" : "Sample JSON output from our service\t",
    "elements" : [
        { 
          "name" : "first",
          "type" : "server",
          "ip" : 7175 
        },
        {
          "name" : "second",
          "type" : "proxy",
          "ip" : "71.78.22.43"
        }
    ]
}
```

#### 2.

```python3
#!/usr/bin/env python3

from socket import gethostbyname
from time import sleep
from os import system, name
import json

try :
    import yaml
except :
    os.system("py -m pip install pyyaml")
    import yaml

servers = {'drive.google.com' : '', 'mail.google.com' : '' , 'google.com' : ''}
err_msg = '[ERROR] {host} IP mismatch: {last_ip} {cur_ip}'
clear_console = 'cls' if name == 'nt' else 'clear'
sleep_time = 1
while (True) :
    sleep_time = 1
    for host, ip in servers.items() :
        cur_ip = gethostbyname(host)
        if cur_ip == ip :
            print(f'{host} - {cur_ip}')
            continue
        else :
            print(err_msg.format(host=host, last_ip=ip, cur_ip=cur_ip))
            servers[host] = cur_ip
            sleep_time = 3
    with open('hosts.json', 'w') as js:
         json.dump(servers, js)
    with open('hosts.yml', 'w') as ym :
         ym.write(yaml.dump(servers))
    sleep(sleep_time)
    system(clear_console)
```
#### *