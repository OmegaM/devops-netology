# 14.4 Сервис-аккаунты

#### 1.
```bash
kubectl create serviceaccount netology                                                                                                                              ─╯
serviceaccount/netology created

kubectl get serviceaccounts                                                                                                                                         ─╯
NAME       SECRETS   AGE
default    1         111s
netology   1         22s

kubectl get serviceaccount                                                                                                                                          ─╯
NAME       SECRETS   AGE
default    1         2m4s
netology   1         35s

 kubectl get serviceaccount netology -o yaml                                                                                                                         ─╯
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2022-05-29T09:01:48Z"
  name: netology
  namespace: lesson-14-04
  resourceVersion: "140201"
  uid: 278c43b7-42e6-42bf-99a5-2a6815be74d6
secrets:
- name: netology-token-29j77

kubectl get serviceaccount default -o json                                                                                                                          ─╯
{
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "creationTimestamp": "2022-05-29T09:00:19Z",
        "name": "default",
        "namespace": "lesson-14-04",
        "resourceVersion": "140136",
        "uid": "52411fd0-dbc5-41dd-bd56-d9ef4ba4ec4f"
    },
    "secrets": [
        {
            "name": "default-token-79jlq"
        }
    ]
}

kubectl get serviceaccounts -o json > serviceaccounts.json && cat serviceaccounts.json                                                                              ─╯
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "ServiceAccount",
            "metadata": {
                "creationTimestamp": "2022-05-29T09:00:19Z",
                "name": "default",
                "namespace": "lesson-14-04",
                "resourceVersion": "140136",
                "uid": "52411fd0-dbc5-41dd-bd56-d9ef4ba4ec4f"
            },
            "secrets": [
                {
                    "name": "default-token-79jlq"
                }
            ]
        },
        {
            "apiVersion": "v1",
            "kind": "ServiceAccount",
            "metadata": {
                "creationTimestamp": "2022-05-29T09:01:48Z",
                "name": "netology",
                "namespace": "lesson-14-04",
                "resourceVersion": "140201",
                "uid": "278c43b7-42e6-42bf-99a5-2a6815be74d6"
            },
            "secrets": [
                {
                    "name": "netology-token-29j77"
                }
            ]
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": "",
        "selfLink": ""
    }
}

kubectl get serviceaccount netology -o yaml > netology.yml && cat netology.yml                                                                                      ─╯
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2022-05-29T09:01:48Z"
  name: netology
  namespace: lesson-14-04
  resourceVersion: "140201"
  uid: 278c43b7-42e6-42bf-99a5-2a6815be74d6
secrets:
- name: netology-token-29j77

kubectl delete serviceaccount netology                                                                                                                              ─╯
serviceaccount "netology" deleted
k get sa                                                                                                                                                            ─╯
NAME      SECRETS   AGE
default   1         3m56s

kubectl apply -f netology.yml                                                                                                                                       ─╯
serviceaccount/netology created

 k get sa                                                                                                                                                            ─╯
NAME       SECRETS   AGE
default    1         4m27s
netology   2         15s
```