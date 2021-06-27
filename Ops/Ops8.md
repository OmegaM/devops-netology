# 3.8. Компьютерные сети, лекция 3

#### 1.
[4.11. What is an ActiveConn/InActConn (Active/Inactive) connnection?](http://www.austintek.com/LVS/LVS-HOWTO/HOWTO/LVS-HOWTO.ipvsadm.html#ActiveConn)

```
InActConn - any other state
...
Normal operation

Services like http (in non-persistent i.e. HTTP /1.0 mode) or ftp-data(port 20) which close the connections as soon as the hit/data (html page, or gif etc) has been retrieved (<1sec). 
...
You'll see an entry in the InActConn column untill the connection times out. 
If you're getting 1000connections/sec and it takes 60secs for the connection to time out (the normal timeout), then you'll have 60,000 InActConns.
...
```
#### 2.
```
root@Balancer1:/home/vagrant# cat /etc/keepalived/keepalived.conf
vrrp_script chk_nginx {
        script "systemctl status nginx"
        interval 2
}

vrrp_instance VI_1 {
        state MASTER
        interface eth1
        virtual_router_id 33
        priority 100
        advert_int 1
        authentication {
                auth_type PASS
                auth_pass netology_secret
        }
        virtual_ipaddress {
                172.28.128.200/24 dev eth1
        }
        track_script {
                chk_nginx
        }
}
```

```
root@Balancer2:/home/vagrant# cat /etc/keepalived/keepalived.conf
vrrp_instance VI_1 {
            state BACKUP
            interface eth1
            virtual_router_id 33
            priority 50
            advert_int 1
            authentication {
                auth_type PASS
                auth_pass netology_secret
            }
            virtual_ipaddress {
                172.28.128.200/24 dev eth1
           }
            track_script {
                chk_nginx
            }
}

vrrp_script chk_nginx {
        script "systemctl status nginx"
        interval 2
}
```
```
root@Balancer1:/home/vagrant# ipvsadm -Ln --stats
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port               Conns   InPkts  OutPkts  InBytes OutBytes
  -> RemoteAddress:Port
TCP  172.28.128.200:80                 217      648        0    38880        0
  -> 172.28.128.100:80                 108      322        0    19320        0
  -> 172.28.128.110:80                 109      326        0    19560        0
  
root@Balancer2:/home/vagrant# ipvsadm -Ln --stats
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port               Conns   InPkts  OutPkts  InBytes OutBytes
  -> RemoteAddress:Port
TCP  172.28.128.200:80                   0        0        0        0        0
  -> 172.28.128.100:80                   0        0        0        0        0
  -> 172.28.128.110:80                   0        0        0        0        0
```
```
root@Balancer1:/home/vagrant# ip link set down eth1
root@Balancer1:/home/vagrant# ip link show eth1
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
    link/ether 08:00:27:24:27:99 brd ff:ff:ff:ff:ff:ff
    
root@Balancer2:/home/vagrant# ipvsadm -Ln --stats
IP Virtual Server version 1.2.1 (size=4096)
Prot LocalAddress:Port               Conns   InPkts  OutPkts  InBytes OutBytes
  -> RemoteAddress:Port
TCP  172.28.128.200:80                  26       75        0     4500        0
  -> 172.28.128.100:80                  13       38        0     2280        0
  -> 172.28.128.110:80                  13       37        0     2220        0
```
#### 3.
Предполагаю, что если мы хотим зайдествовать 3 балансировщика одновременно,
то следует использовать 3 VIP и 4 мастер балансирощика,
что позволит, при падении одного из балансировщиков переключиться на бэкап и продолжить работу с 3 активными

