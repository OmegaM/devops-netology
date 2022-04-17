# 13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet

#### 1
[чарт](./helm_chart/)
#### 2
```bash
omi@DESKTOP-128QIUO:/mnt/d/k8s/lesson-13.04$ helm install -n app1 app1 helm_chart/
NAME: app1
LAST DEPLOYED: Sun Apr 17 14:42:24 2022
NAMESPACE: app1
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:

omi@DESKTOP-128QIUO:/mnt/d/k8s/lesson-13.04$ helm upgrade --install -n app1 app1 helm_chart/
Release "app1" has been upgraded. Happy Helming!
NAME: app1
LAST DEPLOYED: Sun Apr 17 14:43:03 2022
NAMESPACE: app1
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:

omi@DESKTOP-128QIUO:/mnt/d/k8s/lesson-13.04$ helm upgrade --install -n app2 app1 helm_chart/
Release "app1" does not exist. Installing it now.
NAME: app1
LAST DEPLOYED: Sun Apr 17 14:43:37 2022
NAMESPACE: app2
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:

omi@DESKTOP-128QIUO:/mnt/d/k8s/lesson-13.04$ helm list -a -A
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
app1    app1            2               2022-04-17 14:43:03.3684731 +0300 MSK   deployed        helm-chart-0.1.0        1.16.0
app1    app2            1               2022-04-17 14:43:37.4339765 +0300 MSK   deployed        helm-chart-0.1.0        1.16.0
```
