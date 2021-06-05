# 3.4. Операционные системы, лекция 2

#### 1.
```
vagrant@vagrant:~$ cat /etc/systemd/system/node_exporter.service
[Unit]
Description=Node exporter service

[Service]
ExecStart=/usr/bin/node_exporter/node_exporter $EXTRA_OPTS
Restart = always

[Install]
WantedBy=multi-user.target

vagrant@vagrant:~$ systemctl status node_exporter
● node_exporter.service - Node exporter service
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: inactive (dead)
     
vagrant@vagrant:~$ systemctl start node_exporter
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to start 'node_exporter.service'.
Authenticating as: vagrant,,, (vagrant)
Password:
==== AUTHENTICATION COMPLETE ===
vagrant@vagrant:~$ systemctl status node_exporter
● node_exporter.service - Node exporter service
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2021-06-05 08:35:48 UTC; 25s ago
   Main PID: 1684 (node_exporter)
      Tasks: 4 (limit: 1074)
     Memory: 13.2M
     CGroup: /system.slice/node_exporter.service
             └─1684 /usr/bin/node_exporter/node_exporter

Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.581Z caller=node_exporter.go:113 collector=thermal_zone
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.581Z caller=node_exporter.go:113 collector=time
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.581Z caller=node_exporter.go:113 collector=timex
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.581Z caller=node_exporter.go:113 collector=udp_queues
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.581Z caller=node_exporter.go:113 collector=uname
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.582Z caller=node_exporter.go:113 collector=vmstat
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.582Z caller=node_exporter.go:113 collector=xfs
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.582Z caller=node_exporter.go:113 collector=zfs
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.587Z caller=node_exporter.go:195 msg="Listening on" address=:9100
Jun 05 08:35:48 vagrant node_exporter[1684]: level=info ts=2021-06-05T08:35:48.590Z caller=tls_config.go:191 msg="TLS is disabled." http2=false

 curl http://localhost:9100
<html>
                        <head><title>Node Exporter</title></head>
                        <body>
                        <h1>Node Exporter</h1>
                        <p><a href="/metrics">Metrics</a></p>
                        </body>
                        </html>
                        
vagrant@vagrant:~$ systemctl stop node_exporter
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to stop 'node_exporter.service'.
Authenticating as: vagrant,,, (vagrant)
Password:
==== AUTHENTICATION COMPLETE ===
vagrant@vagrant:~$ systemctl status node_exporter
● node_exporter.service - Node exporter service
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Sat 2021-06-05 08:50:04 UTC; 13s ago
    Process: 1038 ExecStart=/usr/bin/node_exporter/node_exporter (code=killed, signal=TERM)
   Main PID: 1038 (code=killed, signal=TERM)

Jun 05 08:49:55 vagrant node_exporter[1038]: level=info ts=2021-06-05T08:49:55.387Z caller=node_exporter.go:113 collector=udp_queues
Jun 05 08:49:55 vagrant node_exporter[1038]: level=info ts=2021-06-05T08:49:55.387Z caller=node_exporter.go:113 collector=uname
Jun 05 08:49:55 vagrant node_exporter[1038]: level=info ts=2021-06-05T08:49:55.387Z caller=node_exporter.go:113 collector=vmstat
Jun 05 08:49:55 vagrant node_exporter[1038]: level=info ts=2021-06-05T08:49:55.387Z caller=node_exporter.go:113 collector=xfs
Jun 05 08:49:55 vagrant node_exporter[1038]: level=info ts=2021-06-05T08:49:55.387Z caller=node_exporter.go:113 collector=zfs
Jun 05 08:49:55 vagrant node_exporter[1038]: level=info ts=2021-06-05T08:49:55.387Z caller=node_exporter.go:195 msg="Listening on" address=:9100
Jun 05 08:49:55 vagrant node_exporter[1038]: level=info ts=2021-06-05T08:49:55.392Z caller=tls_config.go:191 msg="TLS is disabled." http2=false
Jun 05 08:50:04 vagrant systemd[1]: Stopping Node exporter service...
Jun 05 08:50:04 vagrant systemd[1]: node_exporter.service: Succeeded.
Jun 05 08:50:04 vagrant systemd[1]: Stopped Node exporter service.
```
#### 2.

--collector.cpu.info - Enables metric cpu_info

--collector.systemd.enable-restarts-metrics - Enables service unit metric service_restart_total

--collector.systemd.enable-start-time-metrics - Enables service unit metric unit_start_time_seconds

--collector.network_route - Enable the network_route collector (default: disabled).

--collector.tcpstat - Enable the tcpstat collector (default: disabled).

node_forks_total Total number of forks.

node_netstat_Tcp_ActiveOpens Statistic TcpActiveOpens.

node_netstat_Tcp_InErrs Statistic TcpInErrs.

node_network_receive_bytes_total Network device statistic receive_bytes.

node_network_transmit_bytes_total Network device statistic transmit_bytes.

node_procs_running Number of processes in runnable state.

node_schedstat_running_seconds_total Number of seconds CPU spent running a process.


#### 3.

![netdata](imgs\img.png)

#### 4.

[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006

[    0.007237] CPU MTRRs all blank - virtualized system.

#### 5.
```
vagrant@vagrant:~$ sysctl fs.nr_open
fs.nr_open = 1048576
vagrant@vagrant:~$ ulimit -aH
...
open files                      (-n) 1048576
...
```
#### 6.

#### 7.

[Википедия](https://en.wikipedia.org/wiki/Fork_bomb)

[StackExchange](https://askubuntu.com/questions/159491/why-did-the-command-make-my-system-lag-so-badly-i-had-to-reboot)
```
:() means you are defining a function called :

{:|: &} means run the function : and send its output to the : function again and run that in the background.

The ; is a command separator.

: runs the function the first time.

Essentially you are creating a function that calls itself twice every call and doesn't have any way to terminate itself. It will keep doubling up until you run out of system resources.

Running in Virtualbox was quite sensible really otherwise you would have had to restart your pc.
```
[  177.701872] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-3.scope

```
vagrant@vagrant:~$ cat /sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max
2362

echo 1 > /sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max #Позволит использовать только 1 пид
```

