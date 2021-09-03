# 5.3. Контейнеризация на примере Docker 

#### 1.
* Высоконагруженное монолитное java веб-приложение;
    * Скорее всего, физический сервер, т.к. монолит очень не поворотливый, тяжеловесный, а в нашем случае еще и высоконогруженный, т.е. нужен быстрый доступ к ресурсам.
    * Думаю, еще, есть вариант с виртуалкой, тогда можно сделать несколько инстансов, что повысит отказоустойчивость, и более гладкий релиз, т.к. в случае отказа одного инстанса, можно перевести трафик на другой.
    
* Go-микросервис для генерации отчетов
    * В докер, с докер компоузом, можно будет развернуть всю инфраструкруту всего одной командой.
    
* Nodejs веб-приложение
    * Тоже в докер, можно сделать несколько инстансов, настроить балансировку трафика и бесшовно накатывать новые версии
    
* Мобильное приложение c версиями для Android и iOS
    * Либо виртуалка, либо докер. Не уверен, на сколько тяжело поднимать образы для мобильных приложений.
    
* База данных postgresql используемая, как кэш
    * Точно на физический сервер, т.к. кэш - большая I/O нагрузка, которая лучше будет чувствовать себя ближе к железке.
    
* Шина данных на базе Apache Kafka
    * Скорее всего, виртуалка, т.к. кафка является брокером сообщений, отказ в его работе может повлечь потерю сообщений отправляемых между сервисами, что может привести к печальным последствиям.
    * Есть вариант, если кафка используется на тесте и не должен передовать сообщения, а нужна просто для фиксиции корректной отправки сообщений от сервисов, считаю, в этом случае, вполне подойдет докер.
    
* Очередь для Logstash на базе Redis 
    * Т.к. Logstash служит для обработки и генерации журналов или событий, иммет смысл, разместить его на виртуалке или физической машине, и обрабатывать запросы с большого кол-ва других виртуалок или контейнеров. Находясь на физической машине, отсутствует обращение к гипервизору, что поможет сократить расходы ресурсов и времени.
    
* Elastic stack для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana
    * 
    
* Мониторинг-стек на базе prometheus и grafana
    * у нас стоит к кубере. проблем не вижу, быстрее разворачивать, проще масштабировать.
    
* Mongodb, как основное хранилище данных для java-приложения
    * Если персональных/коммерческих/секретных/тайных/и т.д. данных нет, то подойдет облако, т.к. в задании не сказано о нагруженности приложения, ресурсами можно будет управлять динамически, что сократит расходы.
    * Если таковые данные, все же есть, то скорее всего, я бы выбрал виртуалку, как основное хранилище, при этом думаю можно поднять несколько slave контейнеров.
    
* Jenkins-сервер
    * У нас стоит в кубере, проблем нет.
    
#### 2.
[Docker Hub](https://hub.docker.com/repository/docker/miost/dev-netology)
miost/dev-netology

```Dockerfile
FROM httpd

RUN echo "<html> \
<head> \
Hey, Netology \
</head> \
<body> \
<h1>I’m kinda DevOps now</h1> \
</body> \
</html>" > /usr/local/apache2/htdocs/index.html
```
#### 3. 
```bash
vagrant@vagrant:~$ mkdir info
vagrant@vagrant:~$ sudo docker pull centos
Using default tag: latest
latest: Pulling from library/centos
7a0437f04f83: Pull complete
Digest: sha256:5528e8b1b1719d34604c87e11dcd1c0a20bedf46e83b5632cdeac91b8c04efc1
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest

vagrant@vagrant:~$ sudo docker run --name centos_test -v info:/share/info -d centos sleep 9999999
288c61173abd3916fb1d9859420cd1dd122146bfdaab01a2af746749e0033102

vagrant@vagrant:~$ sudo docker run --name debian_test -v ~/info:/info -d debian:latest sleep 999999999
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
955615a668ce: Pull complete
Digest: sha256:08db48d59c0a91afb802ebafc921be3154e200c452e4d0b19634b426b03e0e25
Status: Downloaded newer image for debian:latest
4f3663e185eca9eb4efa1f95921d633347fc948fc5c2f41526bff422eb65bca3

vagrant@vagrant:~$ sudo docker exec -it centos_test /bin/bash
[root@0812abb27a5a /]# echo "test" > /share/info/test  
[root@0812abb27a5a /]#

vagrant@vagrant:~$ echo "test2" > info/test2

vagrant@vagrant:~$ sudo docker exec -it debian_test /bin/bash
root@907d22bb8a43:/# ls /info/
test  test2
root@907d22bb8a43:/# cat /info/test /info/test2 
test
test2
```