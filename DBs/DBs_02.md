# 6.2. SQL

#### 1.
```bash
vagrant@vagrant:~$ mkdir backups db_date
vagrant@vagrant:~$ sudo docker run -v backups:/etc/backups -v db_date:/etc/db_date --name sql --rm  -it -e POSTGRES_PASSWORD=admin  postgres:12 su postgres
86790b251a0a05beed2e8f4b98e8e4e4fb494d47970bbab6900814b9d12e6aab
```
#### 2.
```bash
postgres@ff507290f223:/$ pg_createcluster 12 test_cluster --start
Creating new PostgreSQL cluster 12/test_cluster ...
/usr/lib/postgresql/12/bin/initdb -D /var/lib/postgresql/12/test_cluster --auth-local peer --auth-host md5
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/12/test_cluster ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... Etc/UTC
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

Success. You can now start the database server using:

    pg_ctlcluster 12 test_cluster start

Ver Cluster      Port Status Owner    Data directory                      Log file
12  test_cluster 5432 online postgres /var/lib/postgresql/12/test_cluster /var/log/postgresql/postgresql-12-test_cluster.log

postgres@ff507290f223:/$ createdb test_db
postgres@ff507290f223:/$ createuser test-admin-user
postgres@ff507290f223:/$ psql test_db
psql (12.8 (Debian 12.8-1.pgdg100+1))
Type "help" for help.

test_db=# CREATE TABLE orders (id SERIAL PRIMARY KEY, наименование TEXT, цена INTEGER);
CREATE TABLE

test_db=# test_db=# CREATE TABLE clients (id SERIAL PRIMARY KEY, фамилия TEXT, страна_проживания TEXT, заказ SERIAL REFERENCES orders(id));
CREATE TABLE

test_db=# CREATE INDEX ON clients (страна_проживания);
CREATE INDEX

test_db=# \q

postgres@18b95ddb475a:/$ createuser test-simple-user

test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON orders,clients TO "test-simple-user";
GRANT

test_db=# \dt
          List of relations
 Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
 public | clients | table | postgres
 public | orders  | table | postgres
(2 rows)

test_db=# \d+ orders
                                                   Table "public.orders"
    Column    |  Type   | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------------+---------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
 наименование | text    |           |          |                                    | extended |              |
 цена         | integer |           |          |                                    | plain    |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=# \d+ clients
                                                        Table "public.clients"
      Column       |  Type   | Collation | Nullable |                 Default                  | Storage  | Stats target | Description 
-------------------+---------+-----------+----------+------------------------------------------+----------+--------------+-------------
 id                | integer |           | not null | nextval('clients_id_seq'::regclass)      | plain    |              | 
 фамилия           | text    |           |          |                                          | extended |              |
 страна_проживания | text    |           |          |                                          | extended |              |
 заказ             | integer |           | not null | nextval('"clients_заказ_seq"'::regclass) | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна_проживания_idx" btree ("страна_проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=# SELECT grantee, privilege_type 
FROM information_schema.role_table_grants;

test_db=# SELECT DISTINCT grantee, privilege_type
FROM information_schema.role_table_grants;
     grantee      | privilege_type 
------------------+----------------
 PUBLIC           | SELECT
 PUBLIC           | UPDATE
 postgres         | DELETE
 postgres         | INSERT
 postgres         | REFERENCES
 postgres         | SELECT
 postgres         | TRIGGER
 postgres         | TRUNCATE
 postgres         | UPDATE
 test-simple-user | DELETE
 test-simple-user | INSERT
 test-simple-user | SELECT
 test-simple-user | UPDATE
(13 rows)
```
#### 3.
```bash
test_db=# INSERT INTO orders (наименование,цена) VALUES ('Шоколад', 10), ('Принтер', 3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4000);
INSERT 0 5
test_db=# INSERT INTO clients (фамилия,страна_проживания) VALUES ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore','Russia');
INSERT 0 5

test_db=# SELECT COUNT(*) FROM orders;
 count
-------
     5
(1 row)

test_db=# SELECT COUNT(*) FROM clients;
 count 
-------
     5
(1 row)
```
#### 4.
```bash
test_db=# UPDATE clients SET заказ = 3 WHERE id = 1;
UPDATE 1

test_db=# UPDATE clients SET заказ = 4 WHERE id = 2;
UPDATE 1

test_db=# UPDATE clients SET заказ = 5 WHERE id = 3;
UPDATE 1

test_db=# SELECT * FROM clients
JOIN orders ON clients.заказ = orders.id;

 id |       фамилия        | страна_проживания | заказ | id | наименование | цена
----+----------------------+-------------------+-------+----+--------------+------
  4 | Ронни Джеймс Дио     | Russia            |     4 |  4 | Монитор      | 7000
  5 | Ritchie Blackmore    | Russia            |     5 |  5 | Гитара       | 4000
  1 | Иванов Иван Иванович | USA               |     3 |  3 | Книга        |  500
  2 | Петров Петр Петрович | Canada            |     4 |  4 | Монитор      | 7000
  3 | Иоганн Себастьян Бах | Japan             |     5 |  5 | Гитара       | 4000
(5 rows)
```
#### 5.
```bash

test_db=# EXPLAIN ANALYZE SELECT * FROM clients
JOIN orders ON clients.заказ = orders.id;        
                                                   QUERY PLAN
-----------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=112) (actual time=0.026..0.029 rows=5 loops=1)
   Hash Cond: (clients."заказ" = orders.id)
   ->  Seq Scan on clients  (cost=0.00..18.10 rows=810 width=72) (actual time=0.010..0.010 rows=5 loops=1)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=40) (actual time=0.007..0.007 rows=5 loops=1)
         Buckets: 2048  Batches: 1  Memory Usage: 17kB
         ->  Seq Scan on orders  (cost=0.00..22.00 rows=1200 width=40) (actual time=0.003..0.004 rows=5 loops=1)
 Planning Time: 0.121 ms
 Execution Time: 0.052 ms
(8 rows)

```
1. JOIN вызывает "Hash", который в свою очередь вызывает  Seq Scan по таблице orders и создает в памяти хэш со строками из источника, 
хэшированными с помощью того, что используется для объединения данных.
2. Hash Join вызывает Seq Scan по таблице clients и для каждой строки из таблицы проверяет, есть ли join ключ в хэше, если нет, 
   то строка игнорируется, 
   если есть, то Hash Join берет строки из хэша и, основываясь на этой строке, с одной стороны, и всех строках хэша, с другой стороны, генерирует вывод строк.  
   
#### 6.
```bash
postgres@fb3c1f034d1a:/$ pg_dump test_db > /etc/backups/dump.sql

vagrant@vagrant:~$ sudo docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

vagrant@vagrant:~$ sudo docker run -v backups:/etc/backups -v db_date:/etc/db_date --name sql --rm  -it -e POSTGRES_PASSWORD=admin  postgres:12 su postgres
postgres@199cead0537a:/$ ls /etc/backups/
dump.sql

postgres@199cead0537a:/$ createdb test_db

postgres@199cead0537a:/$ psql test_db < /etc/backups/dump.sql 
SET
SET
SET
SET
SET
 set_config 
------------

(1 row)     

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE 
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE   
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval 
--------
      5 
(1 row) 

 setval 
--------
      5 
(1 row) 
        
 setval 
--------
      5 
(1 row)

ALTER TABLE
ALTER TABLE
CREATE INDEX
ALTER TABLE
```
