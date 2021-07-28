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

#### *