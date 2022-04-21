# 13.3 работа с kubectl

#### 1 
```bash
omi@ubuntu-server:~$ kubectl -n devops port-forward svc/frontend 8080:80 --address 0.0.0.0
Forwarding from 0.0.0.0:8080 -> 80
Handling connection for 8080
Handling connection for 8080
```
![front port-forward svc](../imgs/front_port_forward_svc.png)

```bash
omi@ubuntu-server:~$ kubectl -n devops exec svc/frontend -- curl backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    22  100    22    0     0   2444      0 --:--:-- --:--:-- --:--:--  2444
{"detail":"Not Found"}
```

```bash
omi@ubuntu-server:~$ kubectl -n devops port-forward svc/db 5432:5432 --address 0.0.0.0
Forwarding from 0.0.0.0:5432 -> 5432
Handling connection for 5432

omi@ubuntu-server:~$ psql -h 0.0.0.0 -p 5432 -U postgres -d news
psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1), server 13.6)
WARNING: psql major version 12, server major version 13.
         Some psql features might not work.
Type "help" for help.

news=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 news      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)
```
#### 2
```bash
omi@ubuntu-server:~$ kubectl -n devops get po -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
backend-868dc9dd45-qzmhn   1/1     Running   0          16m   10.233.108.2   worker-0   <none>           <none>
db-68d68bdfb7-7dnmq        1/1     Running   0          16m   10.233.73.3    worker-1   <none>           <none>
frontend-f95fcffdb-7j2rb   1/1     Running   0          16m   10.233.73.2    worker-1   <none>           <none>

omi@ubuntu-server:~$ kubectl -n devops scale --replicas 3 deploy/frontend deploy/backend
deployment.apps/frontend scaled
deployment.apps/backend scaled

omi@ubuntu-server:~$ kubectl -n devops get po -o wide
NAME                       READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
backend-868dc9dd45-7mwqn   1/1     Running   0          38s   10.233.73.4    worker-1   <none>           <none>
backend-868dc9dd45-gjprw   1/1     Running   0          38s   10.233.108.3   worker-0   <none>           <none>
backend-868dc9dd45-qzmhn   1/1     Running   0          18m   10.233.108.2   worker-0   <none>           <none>
db-68d68bdfb7-7dnmq        1/1     Running   0          18m   10.233.73.3    worker-1   <none>           <none>
frontend-f95fcffdb-26ngc   1/1     Running   0          38s   10.233.73.5    worker-1   <none>           <none>
frontend-f95fcffdb-7j2rb   1/1     Running   0          18m   10.233.73.2    worker-1   <none>           <none>
frontend-f95fcffdb-jp65s   1/1     Running   0          38s   10.233.108.4   worker-0   <none>           <none>

omi@ubuntu-server:~$ kubectl -n devops scale --replicas 1 deploy/frontend deploy/backend
deployment.apps/frontend scaled
deployment.apps/backend scaled

omi@ubuntu-server:~$ kubectl -n devops get po -o wide
NAME                       READY   STATUS    RESTARTS   AGE    IP             NODE       NOMINATED NODE   READINESS GATES
backend-868dc9dd45-7mwqn   1/1     Running   0          110s   10.233.73.4    worker-1   <none>           <none>
db-68d68bdfb7-7dnmq        1/1     Running   0          19m    10.233.73.3    worker-1   <none>           <none>
frontend-f95fcffdb-jp65s   1/1     Running   0          110s   10.233.108.4   worker-0   <none>           <none>
```