# 14.3 Карты конфигураций

#### 1. 
```bash
kubectl create configmap nginx-config --from-file=nginx.conf                                                                                                              ─╯
configmap/nginx-config created

kubectl create configmap domain --from-literal=name=netology.ru                                                                                                           ─╯
configmap/domain created
```
#### 2.
```bash 
 k get cm                                                                                                                                                                  ─╯
NAME               DATA   AGE
domain             1      21s
kube-root-ca.crt   1      5d1h
nginx-config       1      34s
```
#### 3.
```bash
kubectl describe configmap domain                                                                                                                                         ─╯
Name:         domain
Namespace:    test
Labels:       <none>
Annotations:  <none>

Data
====
name:
----
netology.ru

BinaryData
====

Events:  <none>
```

#### 4.
```bash
kubectl get configmap nginx-config -o yaml                                                                                                                                ─╯
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2022-05-22T09:58:04Z"
  name: nginx-config
  namespace: test
  resourceVersion: "26862313"
  selfLink: /api/v1/namespaces/test/configmaps/nginx-config
  uid: 480a7994-0de9-4f0c-ba18-71c7d4b0130d

kubectl get configmap domain -o json                                                                                                                                      ─╯
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2022-05-22T09:58:17Z",
        "name": "domain",
        "namespace": "test",
        "resourceVersion": "26862349",
        "selfLink": "/api/v1/namespaces/test/configmaps/domain",
        "uid": "c5cae229-1fef-4f21-a4a8-2a7aa5b95402"
    }
}
```
#### 5.
```bash
kubectl get configmaps -o json > configmaps.json && cat configmaps.json                                                                                                   ─╯
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "data": {
                "name": "netology.ru"
            },
            "kind": "ConfigMap",
            "metadata": {
                "creationTimestamp": "2022-05-22T09:58:17Z",
                "name": "domain",
                "namespace": "test",
                "resourceVersion": "26862349",
                "selfLink": "/api/v1/namespaces/test/configmaps/domain",
                "uid": "c5cae229-1fef-4f21-a4a8-2a7aa5b95402"
            }
        },
        {
            "apiVersion": "v1",
            "data": {
                "ca.crt": "<BASE64_CA_CERT>"
            },
            "kind": "ConfigMap",
            "metadata": {
                "creationTimestamp": "2022-05-17T08:09:26Z",
                "name": "kube-root-ca.crt",
                "namespace": "test",
                "resourceVersion": "25630514",
                "selfLink": "/api/v1/namespaces/test/configmaps/kube-root-ca.crt",
                "uid": "1ddcf1dc-3f97-482c-b0de-029fbb89464e"
            }
        },
        {
            "apiVersion": "v1",
            "data": {
                "nginx.conf": "server {\n    listen 80;\n    server_name  netology.ru www.netology.ru;\n    access_log  /var/log/nginx/domains/netology.ru-access.log  main;\n    error_log   /var/log/nginx/domains/netology.ru-error.log info;\n    location / {\n        include proxy_params;\n        proxy_pass http://10.10.10.10:8080/;\n    }\n}\n"
            },
            "kind": "ConfigMap",
            "metadata": {
                "creationTimestamp": "2022-05-22T09:58:04Z",
                "name": "nginx-config",
                "namespace": "test",
                "resourceVersion": "26862313",
                "selfLink": "/api/v1/namespaces/test/configmaps/nginx-config",
                "uid": "480a7994-0de9-4f0c-ba18-71c7d4b0130d"
            }
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": "",
        "selfLink": ""
    }
}

kubectl get configmap nginx-config -o yaml > nginx-config.yml && cat nginx-config.yml                                                                                     ─╯
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2022-05-22T09:58:04Z"
  name: nginx-config
  namespace: test
  resourceVersion: "26862313"
  selfLink: /api/v1/namespaces/test/configmaps/nginx-config
  uid: 480a7994-0de9-4f0c-ba18-71c7d4b0130d
```

#### 6.
```bash
kubectl delete configmap nginx-config                                                                                                                                     ─╯
configmap "nginx-config" deleted
```

#### 7.
```bash
kubectl apply -f nginx-config.yml                                                                                                                                         ─╯
configmap/nginx-config created
```
