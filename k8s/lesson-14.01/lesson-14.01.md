# 14.1 Создание и использование секретов

#### 1. 
```bash
openssl genrsa -out cert.key 4096                                                                                                                                         ─╯
Generating RSA private key, 4096 bit long modulus
...............................................................................................................................................................++
...................................................++
e is 65537 (0x10001)

openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \                                                                                                           ─╯
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'

kubectl create secret tls domain-cert --cert=cert.crt --key=cert.key                                                                                                      ─╯
secret/domain-cert created
```
#### 2.
```bash
k get secrets                                                                                                                                                             ─╯
NAME                  TYPE                                  DATA   AGE
default-token-jkt8g   kubernetes.io/service-account-token   3      65s
domain-cert           kubernetes.io/tls                     2      29s
```

#### 3.
```bash
k describe secrets domain-cert                                                                                                                                            ─╯
Name:         domain-cert
Namespace:    test
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/tls

Data
====
tls.crt:  1805 bytes
tls.key:  3247 bytes
```
#### 4. 
```bash
kubectl get secret domain-cert -o yaml                                                                                                                                    ─╯
apiVersion: v1
data:
  tls.crt: <BASE64_CERT>
  tls.key: <BASE64_KEY>
kind: Secret
metadata:
  creationTimestamp: "2022-05-22T08:49:10Z"
  name: domain-cert
  namespace: test
  resourceVersion: "26850577"
  selfLink: /api/v1/namespaces/test/secrets/domain-cert
  uid: e19c6027-3b7e-4fd9-81f4-67905709e90f
type: kubernetes.io/tls


kubectl get secret domain-cert -o json                                                                                                                                    ─╯
{
    "apiVersion": "v1",
    "data": {
        "tls.crt": "<BASE64_CERT>",
        "tls.key": "<BASE64_KEY>"
    },
    "kind": "Secret",
    "metadata": {
        "creationTimestamp": "2022-05-22T08:49:10Z",
        "name": "domain-cert",
        "namespace": "test",
        "resourceVersion": "26850577",
        "selfLink": "/api/v1/namespaces/test/secrets/domain-cert",
        "uid": "e19c6027-3b7e-4fd9-81f4-67905709e90f"
    },
    "type": "kubernetes.io/tls"
}
```

#### 5. 
```bash
kubectl get secrets -o json > secrets.json && cat secrets.json                                                                                                            ─╯
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "data": {
                "ca.crt": "<BASE64_KUBER_CA_CRT>",
                "namespace": "dGVzdA==",
                "token": "<BASE64_KUBER_TOKEN>"
            },
            "kind": "Secret",
            "metadata": {
                "annotations": {
                    "kubernetes.io/service-account.name": "default",
                    "kubernetes.io/service-account.uid": "f8c2858d-c559-4e9d-89f3-c52bb76491ae"
                },
                "creationTimestamp": "2022-05-22T08:48:34Z",
                "name": "default-token-jkt8g",
                "namespace": "test",
                "resourceVersion": "26850476",
                "selfLink": "/api/v1/namespaces/test/secrets/default-token-jkt8g",
                "uid": "bf12bbb3-2b5d-4a3e-84ae-98649ace058e"
            },
            "type": "kubernetes.io/service-account-token"
        },
        {
            "apiVersion": "v1",
            "data": {
                "tls.crt": "<BASE64_CRT>",
                "tls.key": "<BASE64_KEY>"
            },
            "kind": "Secret",
            "metadata": {
                "creationTimestamp": "2022-05-22T08:49:10Z",
                "name": "domain-cert",
                "namespace": "test",
                "resourceVersion": "26850577",
                "selfLink": "/api/v1/namespaces/test/secrets/domain-cert",
                "uid": "e19c6027-3b7e-4fd9-81f4-67905709e90f"
            },
            "type": "kubernetes.io/tls"
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": "",
        "selfLink": ""
    }
}

kubectl get secret domain-cert -o yaml > domain-cert.yml && cat domain-cert.yml                                                                                           ─╯
apiVersion: v1
data:
  tls.crt: <BASE64_CRT>
  tls.key: <BASE64_KEY>
kind: Secret
metadata:
  creationTimestamp: "2022-05-22T08:49:10Z"
  name: domain-cert
  namespace: test
  resourceVersion: "26850577"
  selfLink: /api/v1/namespaces/test/secrets/domain-cert
  uid: e19c6027-3b7e-4fd9-81f4-67905709e90f
type: kubernetes.io/tls
```

#### 6.
```bash
kubectl delete secret domain-cert                                                                                                                                         ─╯
secret "domain-cert" deleted
```
#### 7.
```bash
kubectl apply -f domain-cert.yml                                                                                                                                          ─╯
secret/domain-cert created
```

#### 8*.
```bash
cat alpine.yml                                                                                                                                                            ─╯
apiVersion: v1
kind: Pod
metadata:
  name: alpine
  labels:
    app: alpine
spec:
  containers:
  - name: alpine
    image: alpine
    stdin: true
    tty: true
    resources:
      limits:
        cpu: "1"
        memory: 256Mi
    env:
      - name: TLS_CERT
        valueFrom:
          secretKeyRef:
            name: domain-cert
            key: tls.crt
      - name: TLS_KEY
        valueFrom:
          secretKeyRef:
            name: domain-cert
            key: tls.key
    volumeMounts:
      - mountPath: /secret
        name: secret
        readOnly: true

  volumes:
    - name: secret
      secret:
        secretName: domain-cert

k apply -f alpine.yml                                                                                                                                                     ─╯
pod/alpine created

k exec alpine -- ls /secret/                                                                                                                                              ─╯
tls.crt
tls.key

k exec alpine -- cat /secret/tls.crt                                                                                                                                      ─╯
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----

k exec alpine -- env | grep TLS                                                                                                                                           ─╯
TLS_KEY=-----BEGIN RSA PRIVATE KEY-----
TLS_CERT=-----BEGIN CERTIFICATE-----
```