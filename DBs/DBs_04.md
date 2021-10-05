# 6.4. PostgreSQL

#### 1.
```bash
vagrant@vagrant:~$ sudo docker run --name sql -it --rm -v backups:/etc/backups -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:13 /bin/bash
Unable to find image 'postgres:13' locally
13: Pulling from library/postgres
bd897bb914af: Pull complete
7f145551e8b9: Pull complete
d21bf1caa4a5: Pull complete
7d593d17cf79: Pull complete
c468fd1ea184: Pull complete
cd96a2d4842d: Pull complete
12fbbf9d6306: Pull complete
59e3d6202528: Pull complete
c3473a780272: Pull complete
21e4ce30f33d: Pull complete
48d1fcc58373: Pull complete
ef3012c209e8: Pull complete
fc76514fcc17: Pull complete
Digest: sha256:a5674edf4d0b67ca5bb9eb3b1e2c381b7e7e92ae3d2eb8c3e79eb3d4c769a288
Status: Downloaded newer image for postgres:13

root@0381462d6ea7:/# su postgres
postgres@0381462d6ea7:/$ psql
psql (13.4 (Debian 13.4-4.pgdg110+1))
Type "help" for help.

postgres=# \?
General
  \copyright             show PostgreSQL usage and distribution terms
  \crosstabview [COLUMNS] execute query and display results in crosstab
  \errverbose            show most recent error message at maximum verbosity
  \g [(OPTIONS)] [FILE]  execute query (and send results to file or |pipe);
                         \g with no arguments is equivalent to a semicolon
  \gdesc                 describe result of query, without executing it
  \gexec                 execute query, then execute each value in its result
  \gset [PREFIX]         execute query and store results in psql variables
  \gx [(OPTIONS)] [FILE] as \g, but forces expanded output mode
  \q                     quit psql
  \watch [SEC]           execute query every SEC seconds

Help
  \? [commands]          show help on backslash commands
  \? options             show help on psql command-line options
  \? variables           show help on special variables
  \h [NAME]              help on syntax of SQL commands, * for all commands

Query Buffer
  \e [FILE] [LINE]       edit the query buffer (or file) with external editor
  \ef [FUNCNAME [LINE]]  edit function definition with external editor
  \ev [VIEWNAME [LINE]]  edit view definition with external editor
  \p                     show the contents of the query buffer
  \r                     reset (clear) the query buffer
  \s [FILE]              display history or save it to file
  \w FILE                write query buffer to file

Input/Output
  \copy ...              perform SQL COPY with data stream to the client host
  \echo [-n] [STRING]    write string to standard output (-n for no newline)
  \i FILE                execute commands from file
  \ir FILE               as \i, but relative to location of current script
  \o [FILE]              send all query results to file or |pipe
  \qecho [-n] [STRING]   write string to \o output stream (-n for no newline)
  \warn [-n] [STRING]    write string to standard error (-n for no newline)

Conditional
  \if EXPR               begin conditional block
  \elif EXPR             alternative within current conditional block
  \else                  final alternative within current conditional block
  \endif                 end conditional block

Informational
  (options: S = show system objects, + = additional detail)
  \d[S+]                 list tables, views, and sequences
  \d[S+]  NAME           describe table, view, sequence, or index
  \da[S]  [PATTERN]      list aggregates
  \dA[+]  [PATTERN]      list access methods
  \dAc[+] [AMPTRN [TYPEPTRN]]  list operator classes
  \dAf[+] [AMPTRN [TYPEPTRN]]  list operator families
  \dAo[+] [AMPTRN [OPFPTRN]]   list operators of operator families
  \dAp[+] [AMPTRN [OPFPTRN]]   list support functions of operator families
  \db[+]  [PATTERN]      list tablespaces
  \dc[S+] [PATTERN]      list conversions
  \dC[+]  [PATTERN]      list casts
  \dd[S]  [PATTERN]      show object descriptions not displayed elsewhere
  \dD[S+] [PATTERN]      list domains
  \ddp    [PATTERN]      list default privileges
  \dE[S+] [PATTERN]      list foreign tables
  \det[+] [PATTERN]      list foreign tables
  \des[+] [PATTERN]      list foreign servers
  \deu[+] [PATTERN]      list user mappings
  \dew[+] [PATTERN]      list foreign-data wrappers
  \df[anptw][S+] [PATRN] list [only agg/normal/procedures/trigger/window] functions
  \dF[+]  [PATTERN]      list text search configurations
  \dFd[+] [PATTERN]      list text search dictionaries
  \dFp[+] [PATTERN]      list text search parsers
  \dFt[+] [PATTERN]      list text search templates
  \dg[S+] [PATTERN]      list roles
  \di[S+] [PATTERN]      list indexes
  \dl                    list large objects, same as \lo_list
  \dL[S+] [PATTERN]      list procedural languages
  \dm[S+] [PATTERN]      list materialized views
  \dn[S+] [PATTERN]      list schemas
  \do[S+] [PATTERN]      list operators
  \dO[S+] [PATTERN]      list collations
  \dp     [PATTERN]      list table, view, and sequence access privileges
  \dP[itn+] [PATTERN]    list [only index/table] partitioned relations [n=nested]
  \drds [PATRN1 [PATRN2]] list per-database role settings
  \dRp[+] [PATTERN]      list replication publications
  \dRs[+] [PATTERN]      list replication subscriptions
  \ds[S+] [PATTERN]      list sequences
  \dt[S+] [PATTERN]      list tables
  \dT[S+] [PATTERN]      list data types
  \du[S+] [PATTERN]      list roles
  \dv[S+] [PATTERN]      list views
  \dx[+]  [PATTERN]      list extensions
  \dy[+]  [PATTERN]      list event triggers
  \l[+]   [PATTERN]      list databases
  \sf[+]  FUNCNAME       show a function's definition
  \sv[+]  VIEWNAME       show a view's definition
  \z      [PATTERN]      same as \dp

Formatting
  \a                     toggle between unaligned and aligned output mode
  \C [STRING]            set table title, or unset if none
  \f [STRING]            show or set field separator for unaligned query output
  \H                     toggle HTML output mode (currently off)
  \pset [NAME [VALUE]]   set table output option
                         (border|columns|csv_fieldsep|expanded|fieldsep|
                         fieldsep_zero|footer|format|linestyle|null|
                         numericlocale|pager|pager_min_lines|recordsep|
                         recordsep_zero|tableattr|title|tuples_only|
                         unicode_border_linestyle|unicode_column_linestyle|
                         unicode_header_linestyle)
  \t [on|off]            show only rows (currently off)
  \T [STRING]            set HTML <table> tag attributes, or unset if none
  \x [on|off|auto]       toggle expanded output (currently off)

Connection
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")
  \conninfo              display information about current connection
  \encoding [ENCODING]   show or set client encoding
  \password [USERNAME]   securely change the password for a user

Operating System
  \cd [DIR]              change the current working directory
  \setenv NAME [VALUE]   set or unset environment variable
  \timing [on|off]       toggle timing of commands (currently off)
  \! [COMMAND]           execute command in shell or start interactive shell

Variables
  \prompt [TEXT] NAME    prompt user to set internal variable
  \set [NAME [VALUE]]    set internal variable, or list all if no parameters
  \unset NAME            unset (delete) internal variable

Large Objects
  \lo_export LOBOID FILE
  \lo_import FILE [COMMENT]
  \lo_list
  \lo_unlink LOBOID      large object operations
  
  postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

 \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")
postgres=# \c postgres
You are now connected to database "postgres" as user "postgres".

postgres=# \dt
Did not find any relations.
postgres=# \dtS+
                                        List of relations
   Schema   |          Name           | Type  |  Owner   | Persistence |    Size    | Description
------------+-------------------------+-------+----------+-------------+------------+-------------
 pg_catalog | pg_aggregate            | table | postgres | permanent   | 56 kB      |
 pg_catalog | pg_am                   | table | postgres | permanent   | 40 kB      |
 pg_catalog | pg_amop                 | table | postgres | permanent   | 80 kB      |
 pg_catalog | pg_amproc               | table | postgres | permanent   | 64 kB      |
 pg_catalog | pg_attrdef              | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_attribute            | table | postgres | permanent   | 456 kB     |
 pg_catalog | pg_auth_members         | table | postgres | permanent   | 40 kB      | 
 pg_catalog | pg_authid               | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_cast                 | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_class                | table | postgres | permanent   | 136 kB     |
 pg_catalog | pg_collation            | table | postgres | permanent   | 240 kB     |
 pg_catalog | pg_constraint           | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_conversion           | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_database             | table | postgres | permanent   | 48 kB      |
 pg_catalog | pg_db_role_setting      | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_default_acl          | table | postgres | permanent   | 8192 bytes |
 pg_catalog | pg_depend               | table | postgres | permanent   | 488 kB     |
 ...
postgres=# \q
postgres@0381462d6ea7:/$                 
```
#### 2.
```bash
postgres=# CREATE DATABASE test_database;
CREATE DATABASE
postgres@0381462d6ea7:/$ psql -U postgres -f /etc/backups/test_dump.sql test_database
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
ALTER TABLE
COPY 8     
 setval 
--------
      8 
(1 row) 

ALTER TABLE

postgres@0381462d6ea7:/$ psql 
psql (13.4 (Debian 13.4-4.pgdg110+1))
Type "help" for help.

postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".

test_database=# ANALYSE VERBOSE orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE

test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```
Можно было исключить ручное разбиение, если изначанильно таблица была бы секционированной
#### 3.
```bash
test_database=# alter table orders rename to orders_simple;
ALTER TABLE
test_database=# create table orders (id integer, title varchar(80), price integer) partition by range(price);
CREATE TABLE
test_database=# create table orders_less499 partition of orders for values from (0) to (499);
CREATE TABLE
test_database=# create table orders_more499 partition of orders for values from (499) to (99999);
CREATE TABLE
test_database=# insert into orders (id, title, price) select * from orders_simple;
INSERT 0 8
```
#### 4.
```bash
root@0381462d6ea7:/# pg_dump -U postgres -d test_database > test_database_dump.sql
```
ALTER TABLE ONLY orders ADD UNIQUE(title); - добавит уникальность для значения столбца title