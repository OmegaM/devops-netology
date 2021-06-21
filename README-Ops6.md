# 3.6. Компьютерные сети, лекция 1


#### 2.
[Построение сетей Wi-Fi. Краткий ликбез](https://interface31.ru/tech_it/2011/11/postroenie-setey-wi-fi-kratkiy-likbez.html)

``... в диапазоне есть только три независимых канала, которые могут работать без взаимных помех ... В диапазоне 5 ГГц дела обстоят лучше, можно использовать 22 независимых канала ...``

#### 3.

OUI	| MAC range	| Company 
----|-----------|--------|
38-F9-D3| 38-F9-D3-00-00-00 - 38-F9-D3-FF-FF-FF	| Apple, Inc.

#### 4.
```
MTU (Maximum Transmission Unit) – размер полезных данных в одном фрейме (размер фрейма минус заголовки Ethernet, минус трейлер Ethernet) = 9001
MSS (Maximum Segment Size) – размер полезных данных (payload) в одном сегменте (MTU минус заголовки TCP, минус
заголовки IP) = 9001 - 20 - 32 = 8949
```
9001 - 20 - 32 = 8949
#### 5.
[Configure TCP Options](https://www.juniper.net/documentation/us/en/software/junos/transport-ip/topics/topic-map/tcp-configure-features.html)

Both the SYN and FIN control flags are not normally set in the same TCP segment header. The SYN flag synchronizes sequence numbers to initiate a TCP connection. The FIN flag indicates the end of data transmission to finish a TCP connection. Their purposes are mutually exclusive. A TCP header with the SYN and FIN flags set is anomalous TCP behavior, causing various responses from the recipient, depending on the OS.
#### 6.
[Network Socket](https://en.wikipedia.org/wiki/Network_socket#:~:text=UDP%20sockets%20do%20not%20have,sequentially%20through%20the%20same%20socket.)

UDP sockets do not have a established state, because the protocol is connectionless. A UDP server process handles incoming datagrams from all remote clients sequentially through the same socket.
#### 7.

![Tcp state transition diagram](imgs/tcp_state_transition_diagram.gif)

Step | Client State | Server State | Client Flags Send | Server Flags Send 
-----|--------------|--------------|-------------------|-----------------
Starting point | CLOSED | CLOSED | Nothing | Nothing
Passive Open | CLOSED | LISTENING | Nothing | Nothing
First Handshake  | SYN_SENT | LISTENING | SYN | Nothing
Second Handshake | SYN_SENT | SYN_RCVD | Nothing | SYN + ACK
Third Handshake | ESTABLISHED | ESTABLISHED | ACK | ACK 
First wave  | FIN_WAIT_1 | ESTABLISHED | FIN | ACK
Simultanious close | CLOSING | LAST_ACK | NOTHING  | FIN
Closing | TIME_WAIT, CLOSED | CLOSED | Nothing | Nothing

#### 8.
[coderoad.ru](https://coderoad.ru/2332741/%D0%9A%D0%B0%D0%BA%D0%BE%D0%B2%D0%BE-%D1%82%D0%B5%D0%BE%D1%80%D0%B5%D1%82%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B5-%D0%BC%D0%B0%D0%BA%D1%81%D0%B8%D0%BC%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5-%D0%BA%D0%BE%D0%BB%D0%B8%D1%87%D0%B5%D1%81%D1%82%D0%B2%D0%BE-%D0%BE%D1%82%D0%BA%D1%80%D1%8B%D1%82%D1%8B%D1%85-%D1%81%D0%BE%D0%B5%D0%B4%D0%B8%D0%BD%D0%B5%D0%BD%D0%B8%D0%B9-TCP-%D0%BA%D0%BE%D1%82%D0%BE%D1%80%D0%BE%D0%B5)
```
... реальный предел-это файловые дескрипторы. 
Каждому отдельному соединению сокета присваивается файловый дескриптор, поэтому пределом на самом деле является количество файловых дескрипторов, разрешенных системой, и ресурсов для обработки. 
Максимальный предел обычно превышает 300K, но настраивается, например, с помощью sysctl .
Реалистичные пределы, которыми хвастаются для обычных коробок, составляют около 80 тысяч, например, однопоточных серверов обмена сообщениями Jabber.
```
Если клиентов несколько, то это число умножается на кол-во клиентов
#### 9.
[Проблемы с очередью TIME_WAIT](https://blog.kireev.pro/2017/07/%d0%bf%d1%80%d0%be%d0%b1%d0%bb%d0%b5%d0%bc%d1%8b-%d1%81-%d0%be%d1%87%d0%b5%d1%80%d0%b5%d0%b4%d1%8c%d1%8e-time_wait/)

```
... активная сторона отправляет последний пакет в сессии (ACK на пассивный FIN). 
Поскольку она не может узнать получен ли этот пакет, для неё предусмотрен статус TIME_WAIT. 
В данном состоянии соединение должно находиться время 2 * MSL (максимальное время жизни пакета): время доставки пакета пассивной стороне + время доставки возможного ответного пакета назад.
На практике, в настоящее время, таймер TIME_WAIT устанавливается в 1 — 2 минуты. 
По истечению этого таймера соединение считается закрытым.
...
Проблема TIME_WAIT для исходящих соединений
...
Поскольку оба IP и удаленный порт остаются неизменными, то на каждое новое соединение выделяется новый локальный порт. 
Если клиент был активной стороной завершения TCP-сессии, то это соединение будет заблокировано какое-то время в состоянии TIME_WAIT. 
Если соединения в устанавливаются быстрее чем порты выходят из карантина, то при очередной попытке соединения клиент получит ошибку EADDRNOTAVAIL (errno=99).
Даже если приложения обращаются к разным службам, и ошибка не происходит, очередь TIME_WAIT будет расти, забирая системные ресурсы.
```
#### 10.
[UDP вики](https://ru.wikipedia.org/wiki/UDP)

[TCP вики](https://ru.wikipedia.org/wiki/Transmission_Control_Protocol)

Если размер сегмента UDP превышает размер MTU, то
сегмент фрагментируется на уровне IP
``что может привести к тому, что он вообще не сможет быть доставлен, если промежуточные маршрутизаторы или конечный хост не будут поддерживать фрагментированные IP пакеты.``

В случае с TCP, ``Это приводит к фрагментации и уменьшению скорости передачи полезных данных. Если на каком-либо узле фрагментация запрещена, то со стороны пользователя это выглядит как «зависание» соединений``
#### 11.
В случае, если приложение , в качестве логов, оправляет только stderr, то я бы использовал TCP протокол, т.к. эта информация критична, и ее потеря, может привести к большим потерям
Если логи собираются полностью и их периодичность отправки, позволяет не просматривать их полностью, то UDP протокол будет не критичен в использовании

После прочтения документации по ``syslog``, мое мнение не изменилось
#### 12.
```
vagrant@vagrant:~$ ss -at state listening
Recv-Q               Send-Q                              Local Address:Port                                 Peer Address:Port               Process
0                    4096                                      0.0.0.0:sunrpc                                    0.0.0.0:*
0                    4096                                127.0.0.53%lo:domain                                    0.0.0.0:*
0                    128                                       0.0.0.0:ssh                                       0.0.0.0:*
0                    4096                                         [::]:sunrpc                                       [::]:*
0                    128                                          [::]:ssh                                          [::]:*
```
#### 13.
man tcpdump 
`` -X     When  parsing  and printing, in addition to printing the headers of each packet, print the data of each packet (minus its link level header) in
              hex and ASCII.  This is very handy for analysing new protocols.``

```
vagrant@vagrant:~$ sudo tcpdump -X
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
11:02:53.979825 IP 10.0.2.15.ssh > 10.0.2.2.62900: Flags [P.], seq 3679123015:3679123107, ack 30541935, win 64032, length 92
        0x0000:  4510 0084 ef69 4000 4006 32ea 0a00 020f  E....i@.@.2.....
        0x0010:  0a00 0202 0016 f5b4 db4a f647 01d2 086f  .........J.G...o
        0x0020:  5018 fa20 1887 0000 1ed8 f6d0 9bf5 2bfa  P.............+.
        0x0030:  52a6 5e94 dbb2 b431 6b2f 0eae 73ea e109  R.^....1k/..s...
        0x0040:  0f6e dc04 35c6 afbb 27a4 b28e 367a ec8e  .n..5...'...6z..
        0x0050:  1fd1 9a21 eab0 3182 d56f ccf8 b847 f63d  ...!..1..o...G.=
        0x0060:  0fd1 e4fc f723 a9a7 0d01 d73b afa8 fec6  .....#.....;....
        0x0070:  6899 a917 c49c 6ab7 0b0c e0cc 76df 75cb  h.....j.....v.u.
        0x0080:  7aaf 474e                                z.GN
11:02:53.980803 IP 10.0.2.2.62900 > 10.0.2.15.ssh: Flags [.], ack 92, win 65535, length 0
        0x0000:  4500 0028 9a49 0000 4006 c876 0a00 0202  E..(.I..@..v....
        0x0010:  0a00 020f f5b4 0016 01d2 086f db4a f6a3  ...........o.J..
        0x0020:  5010 ffff c5c9 0000 0000 0000 0000       P.............
```
#### 14.
```
vagrant@vagrant:~$ sudo tcpdump -c 100 not port ssh -X -w tcpdump.pcap &
vagrant@vagrant:~$ tshark -r tcpdump.pcap
    1   0.000000    10.0.2.15 → 10.0.2.3     DNS 76 Standard query 0x6c1a AAAA ya.ru OPT
    2   0.010290     10.0.2.3 → 10.0.2.15    DNS 104 Standard query response 0x6c1a AAAA ya.ru AAAA 2a02:6b8::2:242 OPT
    3   0.011148    10.0.2.15 → 87.250.250.242 TCP 74 56738 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=2660164431 TSecr=0 WS=128
    4   0.020828 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56738 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
    5   0.020883    10.0.2.15 → 87.250.250.242 TCP 54 56738 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
    6   0.021471    10.0.2.15 → 87.250.250.242 HTTP 123 GET / HTTP/1.1
    7   0.022467 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56738 [ACK] Seq=1 Ack=70 Win=65535 Len=0
    8   0.087465 87.250.250.242 → 10.0.2.15    HTTP 715 HTTP/1.1 302 Found
    9   0.087507    10.0.2.15 → 87.250.250.242 TCP 54 56738 → 80 [ACK] Seq=70 Ack=662 Win=63579 Len=0
   10   0.088992    10.0.2.15 → 87.250.250.242 TCP 54 56738 → 80 [FIN, ACK] Seq=70 Ack=662 Win=63579 Len=0
   11   0.090313 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56738 [ACK] Seq=662 Ack=71 Win=65535 Len=0
   12   0.099206 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56738 [FIN, ACK] Seq=662 Ack=71 Win=65535 Len=0
   13   0.099254    10.0.2.15 → 87.250.250.242 TCP 54 56738 → 80 [ACK] Seq=71 Ack=663 Win=63579 Len=0
   14   1.343688    10.0.2.15 → 87.250.250.242 TCP 74 56740 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=2660165764 TSecr=0 WS=128
   15   1.358567 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56740 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   16   1.358667    10.0.2.15 → 87.250.250.242 TCP 54 56740 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
   17   1.359533    10.0.2.15 → 87.250.250.242 HTTP 123 GET / HTTP/1.1
   18   1.359972 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56740 [ACK] Seq=1 Ack=70 Win=65535 Len=0
   19   1.387918 87.250.250.242 → 10.0.2.15    HTTP 715 HTTP/1.1 302 Found
   20   1.387954    10.0.2.15 → 87.250.250.242 TCP 54 56740 → 80 [ACK] Seq=70 Ack=662 Win=63579 Len=0
   21   1.388840    10.0.2.15 → 87.250.250.242 TCP 54 56740 → 80 [FIN, ACK] Seq=70 Ack=662 Win=63579 Len=0
   22   1.389739 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56740 [ACK] Seq=662 Ack=71 Win=65535 Len=0
   23   1.402734 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56740 [FIN, ACK] Seq=662 Ack=71 Win=65535 Len=0
   24   1.402774    10.0.2.15 → 87.250.250.242 TCP 54 56740 → 80 [ACK] Seq=71 Ack=663 Win=63579 Len=0
   25   1.875951    10.0.2.15 → 87.250.250.242 TCP 74 56742 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=2660166296 TSecr=0 WS=128
   26   1.891805 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56742 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   27   1.891900    10.0.2.15 → 87.250.250.242 TCP 54 56742 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
   28   1.892725    10.0.2.15 → 87.250.250.242 HTTP 123 GET / HTTP/1.1
   29   1.893144 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56742 [ACK] Seq=1 Ack=70 Win=65535 Len=0
   30   1.927766 87.250.250.242 → 10.0.2.15    HTTP 715 HTTP/1.1 302 Found
   31   1.927810    10.0.2.15 → 87.250.250.242 TCP 54 56742 → 80 [ACK] Seq=70 Ack=662 Win=63579 Len=0
   32   1.929353    10.0.2.15 → 87.250.250.242 TCP 54 56742 → 80 [FIN, ACK] Seq=70 Ack=662 Win=63579 Len=0
   33   1.930478 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56742 [ACK] Seq=662 Ack=71 Win=65535 Len=0
   34   1.943360 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56742 [FIN, ACK] Seq=662 Ack=71 Win=65535 Len=0
   35   1.943409    10.0.2.15 → 87.250.250.242 TCP 54 56742 → 80 [ACK] Seq=71 Ack=663 Win=63579 Len=0
   36   5.222088 PcsCompu_14:86:db → RealtekU_12:35:03 ARP 42 Who has 10.0.2.3? Tell 10.0.2.15
   37   5.223174 RealtekU_12:35:03 → PcsCompu_14:86:db ARP 60 10.0.2.3 is at 52:54:00:12:35:03
   38   8.219819    10.0.2.15 → 10.0.2.3     DNS 81 Standard query 0x3bfc A google.com OPT
   39   8.220841    10.0.2.15 → 10.0.2.3     DNS 81 Standard query 0xd9a6 AAAA google.com OPT
   40   8.231442     10.0.2.3 → 10.0.2.15    DNS 193 Standard query response 0xd9a6 AAAA google.com AAAA 2a00:1450:4010:c08::8a AAAA 2a00:1450:4010:c08::8b AAAA 2a00:1450:4010:c08::64 AAAA 2a00:1450:4010:c08::71 OPT
   41   8.231442     10.0.2.3 → 10.0.2.15    DNS 177 Standard query response 0x3bfc A google.com A 64.233.165.138 A 64.233.165.139 A 64.233.165.100 A 64.233.165.101 A 64.233.165.102 A 64.233.165.113 OPT
   42   8.232474    10.0.2.15 → 64.233.165.138 TCP 74 38186 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=1816257982 TSecr=0 WS=128
   43   8.253120 64.233.165.138 → 10.0.2.15    TCP 60 80 → 38186 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   44   8.253185    10.0.2.15 → 64.233.165.138 TCP 54 38186 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
   45   8.254116    10.0.2.15 → 64.233.165.138 HTTP 128 GET / HTTP/1.1
   46   8.254569 64.233.165.138 → 10.0.2.15    TCP 60 80 → 38186 [ACK] Seq=1 Ack=75 Win=65535 Len=0
   47   8.280183 64.233.165.138 → 10.0.2.15    HTTP 582 HTTP/1.1 301 Moved Permanently  (text/html)
   48   8.280220    10.0.2.15 → 64.233.165.138 TCP 54 38186 → 80 [ACK] Seq=75 Ack=529 Win=63784 Len=0
   49   8.285525    10.0.2.15 → 64.233.165.138 TCP 54 38186 → 80 [FIN, ACK] Seq=75 Ack=529 Win=63784 Len=0
   50   8.286495 64.233.165.138 → 10.0.2.15    TCP 60 80 → 38186 [ACK] Seq=529 Ack=76 Win=65535 Len=0
   51   8.307147 64.233.165.138 → 10.0.2.15    TCP 60 80 → 38186 [FIN, ACK] Seq=529 Ack=76 Win=65535 Len=0
   52   8.307192    10.0.2.15 → 64.233.165.138 TCP 54 38186 → 80 [ACK] Seq=76 Ack=530 Win=63784 Len=0
   53   9.536620    10.0.2.15 → 64.233.165.113 TCP 74 48640 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=3904700382 TSecr=0 WS=128
   54   9.563846 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48640 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   55   9.563912    10.0.2.15 → 64.233.165.113 TCP 54 48640 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
   56   9.564641    10.0.2.15 → 64.233.165.113 HTTP 128 GET / HTTP/1.1
   57   9.564997 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48640 [ACK] Seq=1 Ack=75 Win=65535 Len=0
   58   9.592237 64.233.165.113 → 10.0.2.15    HTTP 582 HTTP/1.1 301 Moved Permanently  (text/html)
   59   9.592270    10.0.2.15 → 64.233.165.113 TCP 54 48640 → 80 [ACK] Seq=75 Ack=529 Win=63784 Len=0
   60   9.597313    10.0.2.15 → 64.233.165.113 TCP 54 48640 → 80 [FIN, ACK] Seq=75 Ack=529 Win=63784 Len=0
   61   9.597753 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48640 [ACK] Seq=529 Ack=76 Win=65535 Len=0
   62   9.619618 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48640 [FIN, ACK] Seq=529 Ack=76 Win=65535 Len=0
   63   9.619659    10.0.2.15 → 64.233.165.113 TCP 54 48640 → 80 [ACK] Seq=76 Ack=530 Win=63784 Len=0
   64  10.541464    10.0.2.15 → 64.233.165.113 TCP 74 48642 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=3904701387 TSecr=0 WS=128
   65  10.562448 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48642 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   66  10.562512    10.0.2.15 → 64.233.165.113 TCP 54 48642 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
   67  10.563233    10.0.2.15 → 64.233.165.113 HTTP 128 GET / HTTP/1.1
   68  10.563823 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48642 [ACK] Seq=1 Ack=75 Win=65535 Len=0
   69  10.591400 64.233.165.113 → 10.0.2.15    HTTP 582 HTTP/1.1 301 Moved Permanently  (text/html)
   70  10.591434    10.0.2.15 → 64.233.165.113 TCP 54 48642 → 80 [ACK] Seq=75 Ack=529 Win=63784 Len=0
   71  10.596641    10.0.2.15 → 64.233.165.113 TCP 54 48642 → 80 [FIN, ACK] Seq=75 Ack=529 Win=63784 Len=0
   72  10.597264 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48642 [ACK] Seq=529 Ack=76 Win=65535 Len=0
   73  10.631422 64.233.165.113 → 10.0.2.15    TCP 60 80 → 48642 [FIN, ACK] Seq=529 Ack=76 Win=65535 Len=0
   74  10.631471    10.0.2.15 → 64.233.165.113 TCP 54 48642 → 80 [ACK] Seq=76 Ack=530 Win=63784 Len=0
   75  11.946948    10.0.2.15 → 87.250.250.242 TCP 74 56750 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=2660176367 TSecr=0 WS=128
   76  11.988787 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56750 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   77  11.988851    10.0.2.15 → 87.250.250.242 TCP 54 56750 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
   78  11.989658    10.0.2.15 → 87.250.250.242 HTTP 123 GET / HTTP/1.1
   79  11.990197 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56750 [ACK] Seq=1 Ack=70 Win=65535 Len=0
   80  12.071165 87.250.250.242 → 10.0.2.15    HTTP 715 HTTP/1.1 302 Found
   81  12.071200    10.0.2.15 → 87.250.250.242 TCP 54 56750 → 80 [ACK] Seq=70 Ack=662 Win=63579 Len=0
   82  12.072060    10.0.2.15 → 87.250.250.242 TCP 54 56750 → 80 [FIN, ACK] Seq=70 Ack=662 Win=63579 Len=0
   83  12.072852 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56750 [ACK] Seq=662 Ack=71 Win=65535 Len=0
   84  12.084691 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56750 [FIN, ACK] Seq=662 Ack=71 Win=65535 Len=0
   85  12.084731    10.0.2.15 → 87.250.250.242 TCP 54 56750 → 80 [ACK] Seq=71 Ack=663 Win=63579 Len=0
   86  13.839133    10.0.2.15 → 87.250.250.242 TCP 74 56752 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=2660178259 TSecr=0 WS=128
   87  13.850189 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56752 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   88  13.850252    10.0.2.15 → 87.250.250.242 TCP 54 56752 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
   89  13.850892    10.0.2.15 → 87.250.250.242 HTTP 123 GET / HTTP/1.1
   90  13.851246 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56752 [ACK] Seq=1 Ack=70 Win=65535 Len=0
   91  13.877452 87.250.250.242 → 10.0.2.15    HTTP 715 HTTP/1.1 302 Found
   92  13.877500    10.0.2.15 → 87.250.250.242 TCP 54 56752 → 80 [ACK] Seq=70 Ack=662 Win=63579 Len=0
   93  13.879322    10.0.2.15 → 87.250.250.242 TCP 54 56752 → 80 [FIN, ACK] Seq=70 Ack=662 Win=63579 Len=0
   94  13.881707 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56752 [ACK] Seq=662 Ack=71 Win=65535 Len=0
   95  13.889636 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56752 [FIN, ACK] Seq=662 Ack=71 Win=65535 Len=0
   96  13.889685    10.0.2.15 → 87.250.250.242 TCP 54 56752 → 80 [ACK] Seq=71 Ack=663 Win=63579 Len=0
   97  16.588530    10.0.2.15 → 87.250.250.242 TCP 74 56754 → 80 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=2660181009 TSecr=0 WS=128
   98  16.602832 87.250.250.242 → 10.0.2.15    TCP 60 80 → 56754 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460
   99  16.602897    10.0.2.15 → 87.250.250.242 TCP 54 56754 → 80 [ACK] Seq=1 Ack=1 Win=64240 Len=0
  100  16.603664    10.0.2.15 → 87.250.250.242 HTTP 123 GET / HTTP/1.1
```
```
Frame 100: 60 bytes on wire (480 bits), 60 bytes captured (480 bits)
    Encapsulation type: Ethernet (1)
    ...
    [Protocols in frame: eth:ethertype:ip:tcp]
    ...
    Type: IPv4 (0x0800)
    ...
     Source: RealtekU_12:35:02 (52:54:00:12:35:02)
     Address: RealtekU_12:35:02 (52:54:00:12:35:02)
    ...
    Flags: 0x0000
        0... .... .... .... = Reserved bit: Not set
        .0.. .... .... .... = Don't fragment: Not set
        ..0. .... .... .... = More fragments: Not set
    ...
    Protocol: TCP (6)
    ...
```
Flags. 3 bits.
```
00 | 01 | 02
---|---|---
R | DF | MF
```
R, Reserved. 1 bit.
Should be set to 0.

DF, Don't fragment. 1 bit.
Controls the fragmentation of the datagram.
```
Value	| Description
--------|-------------
0	|Fragment if necessary.
1	|Do not fragment.
```
MF, More fragments. 1 bit.
Indicates if the datagram contains additional fragments.
```
Value	| Description
--------|-------------
0	| This is the last fragment.
1	| More fragments follow this fragment.

