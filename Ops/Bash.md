# 4.1. Командная оболочка Bash: Практические навыки

#### 1
c - a+b, т.к ``a`` и ``b`` без символа ``$`` - это просто строки

d - 1+2, т.к переменные указаны с символом ``$`` то их значения подставляются на место их спользования, но все остальное, все еще строка

e - 3, т.к двойные скобки позволяют проводить арифметические вычисления

#### 2
```bash
while ((1==1))
do
curl https://localhost:4757
if (($? != 0))
then
date >> curl.log
else
break 
fi
done
```
#### 3
```bash
#!/usr/bin/env bash
ip_arr=(192.168.0.1 173.194.222.113 87.250.250.242)
iter_count=$([ -z $1 ] && echo 5 || echo $1)
while (($iter_count>=0))
do
        for ip in ${ip_arr[@]}
        do
                telnet $ip 80 >> log
        done
        iter_count=$(($iter_count-1))
done
```
#### 4
```bash
#!/usr/bin/env bash
ip_arr=(192.168.0.1 173.194.222.113 87.250.250.242)
while (true)
do
        for ip in ${ip_arr[@]}
        do
                telnet $ip 80 
                if [ $? != 0 ]
                   echo $ip > error
                   break
                fi
        done
done
```
#### *
Если ``код текущего задания`` - ветка, название которой состоит из этого самого кода, то можно сделать так :

```bash
#!/usr/bin/env bash
branch=$(git branch --show-current)
if ! [[ $1 == "[$branch]"* ]] ||  [[ ${#1} > 30 ]]
then
        exit -1
fi
```
 