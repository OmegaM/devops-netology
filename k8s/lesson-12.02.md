# 12.2 Команды для работы с Kubernetes

#### 1.
```bash
omi@minikube:~$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6b89d599b9-xpc65   1/1     Running   0          5s

omi@minikube:~$ kubectl scale --replicas=2 deploy/hello-node
deployment.apps/hello-node scaled

omi@minikube:~$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6b89d599b9-t8m62   1/1     Running   0          16s
hello-node-6b89d599b9-xpc65   1/1     Running   0          88s

omi@minikube:~$ kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   2/2     2            2           102s
```
#### 2.
```bash
omi@minikube:~$ mkdir ~/.minikube/profiles/developer

omi@minikube:~/.minikube/profiles$ openssl genrsa -out developer.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
......................................................................+++++
..........+++++
e is 65537 (0x010001)

omi@minikube:~/.minikube/profiles$ openssl req -new -key developer.key -out developer.csr -subj "/CN=developer/O=developers"

omi@minikube:~/.minikube/profiles/developer$ openssl x509 -req -in developer.csr -CA ~/.minikube/ca.rt -CAkey ~/.minikube/ca
.key -CAcreateserial -out developer.crt -days 500
Signature ok
subject=CN = developer, O = developers
Getting CA Private Key

omi@minikube:~/.minikube/profiles/developer$ kubectl config set-credentials developer --client-certificate=developer.crt --client-key=developer.key
User "developer" set.

omi@minikube:~/.minikube/profiles/developer$ kubectl config set-context developer-context --cluster=minikube --user=developer
Context "developer-context" created.

omi@minikube:~/.minikube/profiles/developer$ kubectl config view
apiVersion: v1
clusters:
...
contexts:
- context:
    cluster: minikube
    user: developer
  name: developer-context
...
users:
- name: developer
  user:
    client-certificate: /home/omi/.minikube/profiles/developer/developer.crt
    client-key: /home/omi/.minikube/profiles/developer/developer.key
    ...
omi@minikube:~$ cat developer_roles.yml
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: developer-roles
rules:
  - apiGroups: [""]
    resources: ["pods", "pods/log"]
    verbs: ["get", "watch", "list"]

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: developer-role
  namespace: default
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: developer-roles
  apiGroup: rbac.authorization.k8s.io

omi@minikube:~$ kubectl config use-context minikube
Switched to context "minikube".

omi@minikube:~$ kubectl apply -f developer_roles.yml
role.rbac.authorization.k8s.io/developer-roles created
rolebinding.rbac.authorization.k8s.io/developer-role created

omi@minikube:~$ kubectl config use-context developer-context
Switched to context "developer-context".

omi@minikube:~$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6b89d599b9-t8m62   1/1     Running   0          38m
hello-node-6b89d599b9-xpc65   1/1     Running   0          39m

omi@minikube:~$ kubectl describe pod hello-node-6b89d599b9-t8m62
Name:         hello-node-6b89d599b9-t8m62
Namespace:    default
...
omi@minikube:~$ kubectl get deploy
Error from server (Forbidden): deployments.apps is forbidden: User "developer" cannot list resource "deployments" in API group "apps" in the namespace "default"

omi@minikube:~$ kubectl scale --replicas=3 deploy/hello-node
Error from server (Forbidden): deployments.apps "hello-node" is forbidden: User "developer" cannot get resource "deployments" in API group "apps" in the namespace "default"

```
#### 3.
```
omi@minikube:~$ kubectl config use-context minikube
Switched to context "minikube".

omi@minikube:~$ kubectl scale --replicas=5 deploy/hello-node
deployment.apps/hello-node scaled

omi@minikube:~$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6b89d599b9-7wdjz   1/1     Running   0          10s
hello-node-6b89d599b9-gzsdr   1/1     Running   0          10s
hello-node-6b89d599b9-m2vmk   1/1     Running   0          10s
hello-node-6b89d599b9-t8m62   1/1     Running   0          47m
hello-node-6b89d599b9-xpc65   1/1     Running   0          48m
```