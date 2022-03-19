# 12.3 Развертывание кластера на собственных серверах, лекция 1

|Role|Component|Value|
|----|---------|-----|
||RAM||
|Master| OS(Ubuntu server 20.04 LTS) | 4 Gb  |
|Master| Controll plane              | 2 Gb  |
|Worker| OS(Ubuntu server 20.04 LTS) | 4 Gb  |
|Worker| Kubernetes components       | 1 Gb  |
|Monitoring| Cluster monitoring      | 5 Gb  |
|Monitoring| Centralized logging     | 11 Gb |
||CPU||
|Master| OS(Ubuntu server 20.04 LTS) | 2     |
|Master| Controll plane              | 2     |
|Worker| OS(Ubuntu server 20.04 LTS) | 2     |
|Worker| Kubernetes components       | 1     |
|Monitoring| Cluster monitoring      | 1.2   |
|Monitoring| Centralized logging     | 1.4   |
||Disk||
|Master| OS(Ubuntu server 20.04 LTS) | 25 Gb |
|Master| Controll plane              | 50 Gb |
|Worker| OS(Ubuntu server 20.04 LTS) | 25 Gb |
|Worker| Kubernetes components       | 100 Gb|
|Monitoring| Cluster monitoring      | 500 Gb|
|Monitoring| Centralized logging     | 500 Gb|

Из расчета того, что кластер - production, я бы предложил сделать 3 master nodes + 3 worker nodes, что позволит обеспечить стабильную работу кластера, даже в случае падения как master nodes так и worker nodes.
На одной из master nodes разместить сервисы мониторинга кластера и отдельных его компонентов.

|Role|Count|Value|Total|
|----|-----|-----|-----|
||RAM||
|Master| 3 | 6 Gb | 18 Gb     |
|Worker| 3 | 5 Gb | 15 Gb     |
|Monitoring| 1 |16 Gb| 16 Gb  | 
||CPU||
|Master| 3 | 4 | 12           |
|Worker| 3 | 3 | 9            |
|Monitoring | 1 | 2.6 | 2.6   |
||Disk||
|Master| 3 | 75 Gb | 225 Gb   |
|Worker| 3 | 125 Gb| 375 Gb   |
|Monitoring | 1 | 1 Tb | 1 Tb |

Расчет требований приложения.
Так как в задании не указаны требования компонентов к дисковому пространству, предположу следуюзую схему :
DataBase - 25 Gb 
Cache - 25 Gb
Frontend - 1 Gb 
Backend - 5 Gb

|Component | Count | Value | Total |
|----------|-------|-------|-------|
||RAM||
|DataBase  | 3     | 4 Gb  | 12 Gb | 
|Cache     | 3     | 4 Gb  | 12 Gb |
|Frontend  | 5     | 50 Mb | 150 Mb|
|Backend   | 10    | 600 Mb| 6 GB  |
||CPU||
|DataBase  | 3     | 1     | 3     | 
|Cache     | 3     | 1     | 3     |
|Frontend  | 5     | 0.1   | 0.5   |
|Backend   | 10    | 1     | 10    |
||Disk||
|DataBase  | 3     | 25 Gb | 75 Gb | 
|Cache     | 3     | 25 Gb | 75 Gb |
|Frontend  | 5     | 1 Gb  | 5 Gb  |
|Backend   | 10    | 5 Gb  | 50 GB |

Итого : 
| RAM | CPU | Disk |
|-----|-----|------|
||Cluster||
| 49 Gb | 23.6 | 1.6 Tb |
| Applications ||| 
| 30.15 Gb | 20.5 | 205 Gb |
||Total||
| 80 Gb (79.15) | 45 (44,1) | 1.8 Tb (1805 Gb)
