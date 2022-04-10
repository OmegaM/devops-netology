# 13.1 контейнеры, поды, deployment, statefulset, services, endpoints

#### 1
```bash
omi@ubuntu-server:~$ yc container registry create --name registry
done (1s)
id: crpqphpbdbm50fs7ovm6
folder_id: b1g1vtqqr31t61bch70q
name: registry
status: ACTIVE
created_at: "2022-04-09T17:48:44.881Z"
```
```bash
omi@ubuntu-server:~/devkub-homeworks/13-kubernetes-config$ docker-compose up -d
Creating network "13-kubernetes-config_default" with the default driver
Building frontend
Step 1/14 : FROM node:lts-buster as builder
...
Status: Downloaded newer image for node:lts-buster
 ---> 424bc28f998d
Step 2/14 : RUN mkdir /app
 ---> Running in e0d4aad2c4d0
Removing intermediate container e0d4aad2c4d0
 ---> 18d8aa8c298c
Step 3/14 : WORKDIR /app
 ---> Running in 8ad0e9bfb623
Removing intermediate container 8ad0e9bfb623
 ---> 7ab1e5c487c7
Step 4/14 : ADD package.json /app/package.json
 ---> c7d185dd95e5
Step 5/14 : ADD package-lock.json /app/package-lock.json
 ---> ab238c71daf2
Step 6/14 : RUN npm i
 ---> Running in 3eaee18b3e61
...
added 1013 packages, and audited 1014 packages in 3m

64 packages are looking for funding
  run `npm fund` for details

29 vulnerabilities (13 moderate, 14 high, 2 critical)

To address issues that do not require attention, run:
  npm audit fix

To address all issues (including breaking changes), run:
  npm audit fix --force

Run `npm audit` for details.
npm notice
npm notice New minor version of npm available! 8.5.0 -> 8.6.0
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v8.6.0>
npm notice Run `npm install -g npm@8.6.0` to update!
npm notice
Removing intermediate container 3eaee18b3e61
 ---> bf38a4261218
Step 7/14 : ADD . /app
 ---> 28ed9f8f74c8
Step 8/14 : RUN npm run build && rm -rf /app/node_modules
 ---> Running in 8e8832384750

> devops-testapp@1.0.0 build
> cross-env NODE_ENV=production webpack --config webpack.config.js --mode production

ℹ Compiling Production build progress
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db
...
Removing intermediate container 8e8832384750
 ---> 8b64893cce4e

Step 9/14 : FROM nginx:latest
latest: Pulling from library/nginx
 ---> 12766a6745ee
Step 10/14 : RUN mkdir /app
 ---> Running in 42af11d30be5
Removing intermediate container 42af11d30be5
 ---> 4307dfeaf2ef
Step 11/14 : WORKDIR /app
 ---> Running in 71bf093ae77b
Removing intermediate container 71bf093ae77b
 ---> 2a33697296bb
Step 12/14 : COPY --from=builder /app/ /app
 ---> 367ab063f449
Step 13/14 : RUN mv /app/markup/* /app && rm -rf /app/markup
 ---> Running in e1a32a75ff6a
Removing intermediate container e1a32a75ff6a
 ---> 628ed353d04e
Step 14/14 : ADD demo.conf /etc/nginx/conf.d/default.conf
 ---> 698945b6bf15
Successfully built 698945b6bf15
Successfully tagged 13-kubernetes-config_frontend:latest
WARNING: Image for service frontend was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Pulling db (postgres:13-alpine)...
13-alpine: Pulling from library/postgres
...
Building backend
Step 1/8 : FROM python:3.9-buster
3.9-buster: Pulling from library/python
...
Status: Downloaded newer image for python:3.9-buster
 ---> b1ce4d348e6a
Step 2/8 : RUN mkdir /app && python -m pip install pipenv
 ---> Running in ed12236505e1
Collecting pipenv
...
Step 3/8 : WORKDIR /app
 ---> Running in 88c64677a8f8
Removing intermediate container 88c64677a8f8
 ---> 3c14035a6a21
Step 4/8 : ADD Pipfile /app/Pipfile
 ---> 2a318f6cbbcd
Step 5/8 : ADD Pipfile.lock /app/Pipfile.lock
 ---> 153649ce1d6d
Step 6/8 : RUN pipenv install
 ---> Running in f6fdc46cfbf9
 ...
 Step 7/8 : ADD main.py /app/main.py
 ---> 24129c6f6ee4
Step 8/8 : CMD pipenv run uvicorn main:app --reload --host 0.0.0.0 --port 9000
 ---> Running in 13895526f54f
Removing intermediate container 13895526f54f
 ---> 563a22975184
Creating 13-kubernetes-config_db_1       ... done
Creating 13-kubernetes-config_frontend_1 ... done
Creating 13-kubernetes-config_backend_1  ... done

omi@ubuntu-server:~/devkub-homeworks/13-kubernetes-config$ docker-compose ps
             Name                            Command               State                    Ports
-------------------------------------------------------------------------------------------------------------------
13-kubernetes-config_backend_1    /bin/sh -c pipenv run uvic ...   Up      0.0.0.0:9000->9000/tcp,:::9000->9000/tcp
13-kubernetes-config_db_1         docker-entrypoint.sh postgres    Up      5432/tcp
13-kubernetes-config_frontend_1   /docker-entrypoint.sh ngin ...   Up      0.0.0.0:8000->80/tcp,:::8000->80/tcp
```
```bash
omi@ubuntu-server:~/devkub-homeworks/13-kubernetes-config$ docker tag 13-kubernetes-config_backend cr.yandex/crpqphpbdbm50fs7ovm6/backend
omi@ubuntu-server:~/devkub-homeworks/13-kubernetes-config$ docker push cr.yandex/crpqphpbdbm50fs7ovm6/backend
Using default tag: latest
...
latest: digest: sha256:a023e890894401be24bcb088e684091d2028b87c35b98d1bc7da4c631a4e5832 size: 3264

omi@ubuntu-server:~/devkub-homeworks/13-kubernetes-config$ docker tag 13-kubernetes-config_frontend cr.yandex/crpqphpbdbm50fs7ovm6/frontend
omi@ubuntu-server:~/devkub-homeworks/13-kubernetes-config$ docker push cr.yandex/crpqphpbdbm50fs7ovm6/frontend
Using default tag: latest
...
latest: digest: sha256:cd8e4536dc52b288ba82ffd22e5f860302ec4accb4ba81cecf57dfe6754a6f4d size: 2401
```
```bash
omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ kubectl create ns devops-app
namespace/devops-app created

omi@ubuntu-server:~$ kubectl -n devops-app create secret docker-registry regcred --docker-server=cr.yandex/crpqphpbdbm50fs7ovm6 --docker-username=oauth --docker-password="******"
```
```bash
omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ kubectl -n devops-app apply -f stage/
deployment.apps/app created
service/db-service created
persistentvolume/pv created
statefulset.apps/db created

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ kubectl -n devops-app get all
NAME                      READY   STATUS    RESTARTS   AGE
pod/app-9cbdd95d7-fv29m   2/2     Running   0          37s
pod/db-0                  1/1     Running   0          37s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/db-service   ClusterIP   10.233.31.70   <none>        5432/TCP   37s

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/app   1/1     1            1           38s

NAME                            DESIRED   CURRENT   READY   AGE
replicaset.apps/app-9cbdd95d7   1         1         1       37s

NAME                  READY   AGE
statefulset.apps/db   1/1     37s
```
#### 2
```bash
omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ kubectl -n devops-app apply -f prod/
deployment.apps/frontend created
deployment.apps/backend created
deployment.apps/db created
service/frontend created
service/backend created
service/db created

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ k -n devops-app get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/backend-866cf4c5-68825      1/1     Running   0          5m41s
pod/db-68d68bdfb7-wcnk2         1/1     Running   0          5m41s
pod/frontend-69bb99b8b4-zn6k5   1/1     Running   0          5m41s

NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/backend    ClusterIP   10.233.4.141    <none>        80/TCP     5m41s
service/db         ClusterIP   10.233.0.52     <none>        5432/TCP   5m41s
service/frontend   ClusterIP   10.233.60.177   <none>        80/TCP     5m41s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/backend    1/1     1            1           5m41s
deployment.apps/db         1/1     1            1           5m41s
deployment.apps/frontend   1/1     1            1           5m41s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/backend-866cf4c5      1         1         1       5m41s
replicaset.apps/db-68d68bdfb7         1         1         1       5m41s
replicaset.apps/frontend-69bb99b8b4   1         1         1       5m41s

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ k -n devops-app logs backend-866cf4c5-68825
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
INFO:     Started server process [9]
INFO:     Waiting for application startup.
INFO:     Application startup complete.

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ k -n devops-app logs frontend-69bb99b8b4-zn6k5
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/04/10 10:39:35 [notice] 1#1: using the "epoll" event method
2022/04/10 10:39:35 [notice] 1#1: nginx/1.21.6
2022/04/10 10:39:35 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6)
2022/04/10 10:39:35 [notice] 1#1: OS: Linux 5.4.0-96-generic
2022/04/10 10:39:35 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/04/10 10:39:35 [notice] 1#1: start worker processes
2022/04/10 10:39:35 [notice] 1#1: start worker process 30
2022/04/10 10:39:35 [notice] 1#1: start worker process 31

mi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ k -n devops-app logs db-68d68bdfb7-wcnk2
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
2022-04-10 10:38:57.355 UTC [30] WARNING:  no usable system locales were found
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2022-04-10 10:38:58.593 UTC [36] LOG:  starting PostgreSQL 13.6 on x86_64-pc-linux-musl, compiled by gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027, 64-bit
2022-04-10 10:38:58.599 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-04-10 10:38:58.612 UTC [37] LOG:  database system was shut down at 2022-04-10 10:38:58 UTC
2022-04-10 10:38:58.618 UTC [36] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down...2022-04-10 10:38:58.933 UTC [36] LOG:  received fast shutdown request
.2022-04-10 10:38:58.938 UTC [36] LOG:  aborting any active transactions
2022-04-10 10:38:58.939 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
2022-04-10 10:38:58.940 UTC [38] LOG:  shutting down
2022-04-10 10:38:58.963 UTC [36] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-04-10 10:38:59.058 UTC [1] LOG:  starting PostgreSQL 13.6 on x86_64-pc-linux-musl, compiled by gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027, 64-bit
2022-04-10 10:38:59.058 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-04-10 10:38:59.058 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-04-10 10:38:59.066 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-04-10 10:38:59.074 UTC [50] LOG:  database system was shut down at 2022-04-10 10:38:58 UTC
2022-04-10 10:38:59.080 UTC [1] LOG:  database system is ready to accept connections
```
#### 3
```bash
omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ k -n devops-app apply -f prod/endpoint.yml
service/external-api created

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.01$ k -n devops-app get svc
NAME           TYPE           CLUSTER-IP      EXTERNAL-IP              PORT(S)    AGE
backend        ClusterIP      10.233.4.141    <none>                   80/TCP     66m
db             ClusterIP      10.233.0.52     <none>                   5432/TCP   66m
external-api   ExternalName   <none>          geocode-maps.yandex.ru   <none>     3m1s
frontend       ClusterIP      10.233.50.141   <none>                   80/TCP     38m
```