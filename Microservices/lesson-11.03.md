# 11.03 Микросервисы: подходы

#### 1.
Для обеспечения всех требований, считаю, лучшим решением - GitLab.
При настройке агентов(runners) на сервер можно установить Terraform, хранить манифесты в отдельном репозитории, и в зависимости от теробований среды, по событию в репозиториях сервисов мамнипулировать облачной инфраструктурой.
Так же, с помощью Gitlab-CI есть возможность кастомизировать сборки и конфигурации в зависимости, например от ветки на которой произошло событие.
Все чувствительные данные легко хранить в переменных GitLab, изменять которые могут, только те лица, которые имеют подходящие права.
Так же, в GitLab существует возможность размвернуть собственный registry, в котором будут храниться docker образы и/или артифакты сборок.

#### 2.
Для сбора логов, я бы предложил ELK стэк, в разлычных его конфигурациях, в зависимости от ресурсов.
Так , например , LogStash можно заменить на Vector, который менее требователен к ресурсам системы на которой установлен.

#### 3.
Для мониторинга системы и сервисов, предлагаю воспользоваться следующим стэком: 
1. VictoriaMetrics - Легок в настройке, менее требовател к ресурсам чем Prometheus. Самописная БД VM до 20 раз [более производительна и менее требовательна к ресурсам](https://valyala.medium.com/measuring-vertical-scalability-for-time-series-databases-in-google-cloud-92550d78d8ae). Так же, легко интегрируется с уже имеющимися (если таковые есть) серверами Prometheus и его exporters.
2. Grafana - Отличный визуализатор метрик, позволяет настракивать удобные Dashboards и alerts на необходимые метрики. Имеет богатую библиотеку уже сформированных Dashboards. Имеет возможность интеграции с SSO.
3. HashiCorp Consul - Service Discovery. Позволит динамически регистрировать новые сервисы (или новые инстансы) и автоматически добавлять их в систему мониторинга(например на этапе CI/CD).
