# 4.2. Использование Python для решения типовых DevOps задач

#### 1. 
``
TypeError : unsupported operand type(s) for +: 'int' and 'str'
``

c = str(a)+b

c=a+int(b)
#### 2.

```python
import os

bash_command = ["cd ~/devops3-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()

for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:   ', '')
        print(prepare_result)


```
#### 3.
```python
#!/usr/bin/env python3

import os
import sys

dir = os.getcwd()
if sys.argv[1] and os.path.exists(sys.argv[1]) and os.path.isdir(sys.argv[1]):
    dir = sys.argv[1]
    
os.chdir(dir)

bash_command = ["git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено: ', '')
        prepare_result = prepare_result.replace(' ', '') 
        print(dir + prepare_result)
```

#### 4.
```python
#!/usr/bin/env python3

from socket import gethostbyname
from time import sleep
from os import system, name

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
    sleep(sleep_time)
    system(clear_console)
```
Скрипт представляет собой бесконечный цикл, при котором на консоль выводитятся значение хоста и его текущий ``ip``, 
в случае, если текущий адрес и адрес из прошлого вызова совпадает ``у всех хостов``, то цикл повторится через 1 секунду, 
иначе, цикл повториться через 3 секунды. После чего, консоль будет очищена, что создаст ощущение, проверки в реальном времени

#### *
