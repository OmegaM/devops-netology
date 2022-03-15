# 12.1 Компоненты Kubernetes

#### 1
```bash
omi@minikube:~$ sudo apt update && sudo apt upgrade -y && sudo apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
...
omi@minikube:~$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

omi@minikube:~$ echo \
>   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
>   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

omi@minikube:~$ sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
omi@minikube:~$ sudo usermod -aG docker $USER
omi@minikube:~$ newgrp docker
omi@minikube:~$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
omi@minikube:~$ sudo install minikube-linux-amd64 /usr/local/bin/

omi@minikube:~$ minikube version
minikube version: v1.25.2
commit: 362d5fdc0a3dbee389b3d3f1034e8023e72bd3a7

root@minikube:/home/omi# minikube start --vm-driver=none
😄  minikube v1.25.2 on Ubuntu 20.04 (amd64)
✨  Using the none driver based on user configuration

🧯  The requested memory allocation of 1983MiB does not leave room for system overhead (total system memory: 1983MiB). You may face stability issues.
💡  Suggestion: Start minikube with less memory allocated: 'minikube start --memory=1983mb'

👍  Starting control plane node minikube in cluster minikube
🤹  Running on localhost (CPUs=2, Memory=1983MB, Disk=20100MB) ...
ℹ️  OS release is Ubuntu 20.04.4 LTS
🐳  Preparing Kubernetes v1.23.3 on Docker 20.10.13 ...
    ▪ kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
    ▪ kubelet.housekeeping-interval=5m
    > kubectl.sha256: 64 B / 64 B [--------------------------] 100.00% ? p/s 0s
    > kubelet.sha256: 64 B / 64 B [--------------------------] 100.00% ? p/s 0s
    > kubeadm.sha256: 64 B / 64 B [--------------------------] 100.00% ? p/s 0s
    > kubectl: 44.43 MiB / 44.43 MiB [-----------] 100.00% 200.88 MiB p/s 400ms
    > kubeadm: 43.12 MiB / 43.12 MiB [------------] 100.00% 76.84 MiB p/s 800ms
    > kubelet: 118.75 MiB / 118.75 MiB [----------] 100.00% 132.34 MiB p/s 1.1s

root@minikube:/home/omi# minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```
#### 2
```bash
root@minikube:/home/omi# minikube addons enable ingress
 ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
    ▪ Using image k8s.gcr.io/ingress-nginx/controller:v1.1.1
    ▪ Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
🔎  Verifying ingress addon...
🌟  The 'ingress' addon is enabled

root@minikube:/home/omi# minikube addons enable dashboard
    ▪ Using image kubernetesui/dashboard:v2.3.1
    ▪ Using image kubernetesui/metrics-scraper:v1.0.7
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server


🌟  The 'dashboard' addon is enabled

root@minikube:/home/omi# kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
deployment.apps/hello-node created

root@minikube:/home/omi# kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6b89d599b9-jr2sd   1/1     Running   0          14s

root@minikube:/home/omi# kubectl get ns
NAME              STATUS   AGE
default           Active   8m17s
ingress-nginx     Active   5m36s
kube-node-lease   Active   8m19s
kube-public       Active   8m19s
kube-system       Active   8m19s
```
#### 3
```bash
root@minikube:/home/omi# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
...
root@minikube:/home/omi# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
root@minikube:/home/omi# kubectl version --client
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.4", GitCommit:"e6c093d87ea4cbb530a7b2ae91e54c0842d8308a", GitTreeState:"clean", BuildDate:"2022-02-16T12:38:05Z", GoVersion:"go1.17.7", Compiler:"gc", Platform:"linux/amd64"}

root@minikube:/home/omi# kubectl expose deployment hello-node --type=ClusterIP --port=8080
service/hello-node exposed

root@minikube:/home/omi# kubectl port-forward svc/hello-node 8080:8080 --address 0.0.0.0
Forwarding from 0.0.0.0:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
...

omi@DESKTOP-128QIUO:~$ curl http://84.201.132.139:8080/
CLIENT VALUES:
client_address=127.0.0.1
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://84.201.132.139:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=84.201.132.139:8080
user-agent=curl/7.68.0
BODY:
-no body in request-
```

