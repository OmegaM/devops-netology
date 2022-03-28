# 12.5 Сетевые решения CNI

#### 1
Использовал кластер из предыдущего ДЗ

```bash
omi@ubuntu-server:~$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-7c658794b9-2gsk8   1/1     Running   0          105m
nginx-7c658794b9-hrjcq   1/1     Running   0          105m

omi@ubuntu-server:~$ kubectl describe po nginx-7c658794b9-hrjcq | grep IP
              cni.projectcalico.org/podIP: 10.233.73.2/32
              cni.projectcalico.org/podIPs: 10.233.73.2/32
IP:           10.233.73.2
IPs:
  IP:           10.233.73.2

omi@ubuntu-server:~$ kubectl exec -it nginx-7c658794b9-2gsk8 /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@nginx-7c658794b9-2gsk8:/# curl 10.233.73.2
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

omi@ubuntu-server:~/kubernetes-for-beginners/16-networking/20-network-policy/templates/network-policy$ kubectl apply -f 00-default.yaml
networkpolicy.networking.k8s.io/default-deny-ingress created

omi@ubuntu-server:~$ kubectl exec -it nginx-7c658794b9-2gsk8 -- curl 10.233.73.2
(крутиться вечно)

omi@ubuntu-server:~$ kubectl delete netpol default-deny-ingress
networkpolicy.networking.k8s.io "default-deny-ingress" deleted

omi@ubuntu-server:~$ kubectl apply -f nginx.yaml
networkpolicy.networking.k8s.io/nginx created

omi@ubuntu-server:~$ kubectl exec -it nginx-7c658794b9-2gsk8 -- curl 10.233.73.2
(крутиться вечно)

omi@ubuntu-server:~$ kubectl delete netpol nginx
networkpolicy.networking.k8s.io "nginx" deleted

omi@ubuntu-server:~$ kubectl exec -it nginx-7c658794b9-2gsk8 -- curl 10.233.73.2
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

#### 2.
```bash
omi@ubuntu-server:~$ ./calicoctl get ipPool --allow-version-mismatch
NAME           CIDR             SELECTOR
default-pool   10.233.64.0/18   all()

omi@ubuntu-server:~$ ./calicoctl get profile --allow-version-mismatch
NAME
projectcalico-default-allow
kns.default
kns.kube-node-lease
kns.kube-public
kns.kube-system
ksa.default.default
ksa.kube-node-lease.default
ksa.kube-public.default
ksa.kube-system.attachdetach-controller
ksa.kube-system.bootstrap-signer
ksa.kube-system.calico-kube-controllers
ksa.kube-system.calico-node
ksa.kube-system.certificate-controller
ksa.kube-system.clusterrole-aggregation-controller
ksa.kube-system.coredns
ksa.kube-system.cronjob-controller
ksa.kube-system.daemon-set-controller
ksa.kube-system.default
ksa.kube-system.deployment-controller
ksa.kube-system.disruption-controller
ksa.kube-system.dns-autoscaler
ksa.kube-system.endpoint-controller
ksa.kube-system.endpointslice-controller
ksa.kube-system.endpointslicemirroring-controller
ksa.kube-system.ephemeral-volume-controller
ksa.kube-system.expand-controller
ksa.kube-system.generic-garbage-collector
ksa.kube-system.horizontal-pod-autoscaler
ksa.kube-system.job-controller
ksa.kube-system.kube-proxy
ksa.kube-system.namespace-controller
ksa.kube-system.node-controller
ksa.kube-system.nodelocaldns
ksa.kube-system.persistent-volume-binder
ksa.kube-system.pod-garbage-collector
ksa.kube-system.pv-protection-controller
ksa.kube-system.pvc-protection-controller
ksa.kube-system.replicaset-controller
ksa.kube-system.replication-controller
ksa.kube-system.resourcequota-controller
ksa.kube-system.root-ca-cert-publisher
ksa.kube-system.service-account-controller
ksa.kube-system.service-controller
ksa.kube-system.statefulset-controller
ksa.kube-system.token-cleaner
ksa.kube-system.ttl-after-finished-controller
ksa.kube-system.ttl-controller
```