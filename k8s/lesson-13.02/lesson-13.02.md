# 13.2 разделы и монтирование

```bash
omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "gitlab" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k create ns mounts
namespace/mounts created

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ helm install nfs-server stable/nfs-server-provisioner -n mounts
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Sun Apr 10 11:56:51 2022
NAMESPACE: mounts
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The NFS Provisioner service has now been installed.

A storage class named 'nfs' has now been created
and is available to provision dynamic volumes.

You can use this storageclass by creating a `PersistentVolumeClaim` with the
correct storageClassName attribute. For example:

    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: test-dynamic-volume-claim
    spec:
      storageClassName: "nfs"
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
```
#### 1 

```bash
omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts apply -f stage/deployment.yml
deployment.apps/app created

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts get all
NAME                                      READY   STATUS    RESTARTS   AGE
pod/app-c7bd9f448-fhgxw                   2/2     Running   0          43s
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          11m

NAME                                        TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)                                                                                                     AGE
service/nfs-server-nfs-server-provisioner   ClusterIP   10.233.25.4   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   11m

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/app   1/1     1            1           3m

NAME                            DESIRED   CURRENT   READY   AGE
replicaset.apps/app-c7bd9f448   1         1         1       3m

NAME                                                 READY   AGE
statefulset.apps/nfs-server-nfs-server-provisioner   1/1     11m

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts exec -c backend app-c7bd9f448-fhgxw -- touch /data/test.txt

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts exec -it -c frontend app-c7bd9f448-fhgxw -- ls /static
test.txt

```

#### 2
```bash
ubuntu@worker-1:~$ sudo apt install nfs-common -y

ubuntu@worker-0:~$ sudo apt install nfs-common -y

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts apply -f prod/
deployment.apps/frontend created
deployment.apps/backend created
deployment.apps/db created
persistentvolumeclaim/shared created

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts get all
NAME                                      READY   STATUS    RESTARTS   AGE
pod/backend-bd878df96-7fx49               1/1     Running   0          5s
pod/db-68d68bdfb7-b6zjv                   1/1     Running   0          5s
pod/frontend-5d7d9f65b9-fd6k7             1/1     Running   0          5s
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          17m

NAME                                        TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)
          AGE
service/nfs-server-nfs-server-provisioner   ClusterIP   10.233.39.29   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   17m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/backend    1/1     1            1           5s
deployment.apps/db         1/1     1            1           5s
deployment.apps/frontend   1/1     1            1           5s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/backend-bd878df96     1         1         1       6s
replicaset.apps/db-68d68bdfb7         1         1         1       6s
replicaset.apps/frontend-5d7d9f65b9   1         1         1       6s

NAME                                                 READY   AGE
statefulset.apps/nfs-server-nfs-server-provisioner   1/1     17m

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts exec backend-6977c589c8-6qgpx -- touch /data/test.txt

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts exec backend-6977c589c8-6qgpx -- ls /data
test.txt

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts exec frontend-5d7d9f65b9-fd6k7 -- ls /static
test.txt

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts exec frontend-5d7d9f65b9-fd6k7 -- touch /static/test-front.txt

omi@ubuntu-server:~/devops-netology/k8s/lesson-13.02$ k -n mounts exec backend-6977c589c8-6qgpx -- ls /data
test-front.txt
test.txt
```