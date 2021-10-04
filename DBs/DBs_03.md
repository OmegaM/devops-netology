# 6.3. MySQL

#### 1. 
```bash
vagrant@vagrant:~$ docker run --rm -it --name sql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -v backups:/etc/backups mysql:8 mysqld
2021-10-04 13:53:19+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.26-1debian10 started.
2021-10-04 13:53:19+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2021-10-04 13:53:19+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.26-1debian10 started.
2021-10-04 13:53:20+00:00 [Note] [Entrypoint]: Initializing database files
2021-10-04T13:53:20.292319Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.26) initializing of server in progress as process 40
2021-10-04T13:53:20.339842Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2021-10-04T13:53:24.731758Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2021-10-04T13:53:32.455665Z 0 [Warning] [MY-013746] [Server] A deprecated TLS version TLSv1 is enabled for channel mysql_main
2021-10-04T13:53:32.487933Z 0 [Warning] [MY-013746] [Server] A deprecated TLS version TLSv1.1 is enabled for channel mysql_main
2021-10-04T13:53:36.864002Z 6 [Warning] [MY-010453] [Server] root@localhost is created with an empty password ! Please consider switching off the --initialize-insecure option.
2021-10-04 13:53:52+00:00 [Note] [Entrypoint]: Database files initialized
2021-10-04 13:53:52+00:00 [Note] [Entrypoint]: Starting temporary server
mysqld will log errors to /var/lib/mysql/ec41e3f5cc28.err
mysqld is running as pid 87
2021-10-04 13:53:58+00:00 [Note] [Entrypoint]: Temporary server started.
Warning: Unable to load '/usr/share/zoneinfo/iso3166.tab' as time zone. Skipping it.      
Warning: Unable to load '/usr/share/zoneinfo/leap-seconds.list' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo/zone.tab' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo/zone1970.tab' as time zone. Skipping it.

2021-10-04 13:54:43+00:00 [Note] [Entrypoint]: Stopping temporary server
2021-10-04 13:54:47+00:00 [Note] [Entrypoint]: Temporary server stopped

2021-10-04 13:54:47+00:00 [Note] [Entrypoint]: MySQL init process done. Ready for start up.

2021-10-04T13:54:48.456282Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.26) starting as process 1
2021-10-04T13:54:48.512698Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2021-10-04T13:54:50.573341Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2021-10-04T13:54:52.028044Z 0 [Warning] [MY-013746] [Server] A deprecated TLS version TLSv1 is enabled for channel mysql_main
2021-10-04T13:54:52.029057Z 0 [Warning] [MY-013746] [Server] A deprecated TLS version TLSv1.1 is enabled for channel mysql_main
2021-10-04T13:54:52.049258Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2021-10-04T13:54:52.050153Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
2021-10-04T13:54:52.076704Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.2021-10-04T13:54:52.289965Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock
2021-10-04T13:54:52.292240Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.26'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.

vagrant@vagrant:~$ docker exec -it sql mysql -uroot -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 14
Server version: 8.0.26 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
mysql> CREATE DATABASE test_db;
Query OK, 1 row affected (0.05 sec)

root@ec41e3f5cc28:/# mysql -uroot -p  test_db < /etc/backups/test_dump.sql

mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don''t show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.

For server side help, type "help contents"

mysql> \s
--------------
mysql  Ver 8.0.26 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          11
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.26 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 3 min 33 sec

Threads: 2  Questions: 5  Slow queries: 0  Opens: 117  Flush tables: 3  Open tables: 36  Queries per second avg: 0.023
--------------

mysql> SHOW tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM orders WHERE price > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.02 sec)
```
#### 2.
```bash

mysql> CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass';
Query OK, 0 rows affected (0.06 sec)

mysql> ALTER USER 'test'@'localhost' ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
Query OK, 0 rows affected (0.02 sec)

mysql> ALTER USER 'test'@'localhost'
    -> WITH 
    -> MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY 
    -> FAILED_LOGIN_ATTEMPTS 3 
    -> PASSWORD_LOCK_TIME 2;
Query OK, 0 rows affected (0.02 sec)

mysql> GRANT Select ON * TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.02 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE User = 'test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)
```
#### 3.
```bash
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW PROFILES;
+----------+------------+-------------------+
| Query_ID | Duration   | Query             |
+----------+------------+-------------------+
|        1 | 0.00022750 | SET profiling = 1 |
+----------+------------+-------------------+
1 row in set, 1 warning (0.00 sec)

SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc;
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.01 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.38 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.18 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+------------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                      |
+----------+------------+------------------------------------------------------------------------------------------------------------+
|        1 | 0.00022750 | SET profiling = 1                                                                                          |
|        2 | 0.00012825 | SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc       |
|        3 | 0.00159200 | SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc |
|        4 | 0.38694250 | ALTER TABLE orders ENGINE = MyISAM                                                                         |
|        5 | 0.19105675 | ALTER TABLE orders ENGINE = InnoDB                                                                         |
+----------+------------+------------------------------------------------------------------------------------------------------------+
5 rows in set, 1 warning (0.00 sec)
```
#### 4.
```bash
root@ec41e3f5cc28:/# cat /etc/mysql/my.cnf
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

#
# The MySQL  Server configuration file.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

# Custom config should go here
!includedir /etc/mysql/conf.d/

root@ec41e3f5cc28:/# cat /etc/mysql/my.cnf
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

#
# The MySQL  Server configuration file.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

innodb_flush_log_at_trx_commit = 0
innodb_file_format = Barracuda
innodb_log_buffer_size  = 1M
key_buffer_size = 640М
max_binlog_size = 100M

# Custom config should go here
!includedir /etc/mysql/conf.d/
```