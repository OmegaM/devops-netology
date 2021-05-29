# 3.3. Операционные системы, лекция 1

#### 1. 

stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")                           = 0

#### 2. 
```man magic 4```
The database of these “magic patterns” is 
usually located in a binary file in ```/usr/share/misc/magic.mgc``` or a directory of source text magic pattern fragment files in
```/usr/share/misc/magic```.

```openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3```
#### 3.

найти `pid` приложения (или отдельной его части) определить `fd` для этого процесса и перенаправить его поток в новый файл логов

#### 4.

[Википедия](https://ru.wikipedia.org/wiki/%D0%9F%D1%80%D0%BE%D1%86%D0%B5%D1%81%D1%81-%D0%B7%D0%BE%D0%BC%D0%B1%D0%B8)

Зомби не занимают памяти (как процессы-сироты), но блокируют записи в таблице процессов, размер которой ограничен для каждого пользователя и системы в целом.

#### 5.

PID  |  COMM        |    FD | ERR | PATH
-----|--------------|-------|-----|-----
1004 |  vminfo      |    6  | 0   |  /var/run/utmp
554  | dbus-daemon  |   -1  | 2   |  /usr/local/share/dbus-1/system-services
554  |  dbus-daemon |    18 | 0   |  /usr/share/dbus-1/system-services
554  |  dbus-daemon |    -1 |  2  | /lib/dbus-1/system-services
554  |  dbus-daemon |    18 |  0  |  /var/lib/snapd/dbus-1/system-services/

#### 6.

```man uname(2)```

Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.  

#### 7.

оператор ```;``` позволяет вызывать несколько команд последовательно в одну строку, т.е.
```comand1 ; comand2``` сначало выплнит command1, а затем command2.

оператор ```&&``` начнет выполнение комманды справа от оператора только в том случае, если комманда слева завершилась успешно
, т.е. с кодом выхода 0

``set - Set or unset values of shell options and positional parameters. ``

``-e  Exit immediately if a command exits with a non-zero status.``

Смысла использовать оператор `&&` нет, т.к. выполнение комманд завершится немедленно, при exit(0) или же `&&` не сработает
т.к. ``exit() != 0 ``

#### 8.

``-e  Exit immediately if a command exits with a non-zero status.``

``-u  Treat unset variables as an error when substituting.``

``-x  Print commands and their arguments as they are executed.``

```
-o option-name
    Set the variable corresponding to option-name:
              pipefail     the return value of a pipeline is the status of
                           the last command to exit with a non-zero status,
                           or zero if no command exited with a non-zero status
```
Эти параметры могут дать подробную информацию в какой команде ошибка, какой код ошибки(exit_code),
что позволит тратить меньше времени, на поиск источника ошибки, а так же позволяет прослеживать ход выполнения пайпа
#### 9. 

S - 50

I - 43

R - 1


```
Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a
       process:

               D    uninterruptible sleep (usually IO)
               I    Idle kernel thread
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped by job control signal
               t    stopped by debugger during the tracing
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by its parent

       For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group
```