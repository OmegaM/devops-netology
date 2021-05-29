# Lesson 2

#### 1.

type cd

cd is a shell builtin

#### 2.

grep -c <some_string> <some_file>

#### 3. 

PID | USER | PR | NI | VIRT | RES | SHR | S | %CPU | %MEM | TIME+ | COMMAND
| -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | -- 
1 | root | 20 | 0 | 102324 | 11736 | 8504 | S | 0.0 | 0.3 | 0:12.05 | systemd

#### 4.

ls 2> /dev/pts/[NUMBER_OF_TTY]

#### 5.

cat file > another_file

#### 6.

#### 7.

При введении команды bash 5>&1 создается новый дескрипток,
на который перенаправляется поток стандартного ввода

ll /proc/$$/fd/

lrwx------ 1 omi omi 64 May 26 02:38 5 -> /dev/pts/1

Когда выполняется ```echo <text> > /proc/$$/fd/5``` то stdin перенаправляется на 5 поток и получает "нормальный" stdout

#### 8.

#### 9.

```cat /proc/$$/environ``` 
выводит переменные окружения процесса bash (поскольку $$ выдает PID для процесса bash)

такой же результат можно получить через
```env```

#### 10.

```/proc/[PID]/cmdline```

This  read-only  file holds the complete command line for the process, unless the process is a zombie.

```/proc/[pid]/exe``` 
 
is a pointer to the binary which was executed, and appears as a symbolic link.

#### 11.

sse4_2

#### 12.

Это не баг, а фича! 

По умолчанию, при подключению через ssh на удаленый комп. tty не создается,
для того, чтобы можно было свободно передавать файлы,
чтобы принудительно создать tty, нужно использовать флаг

-t      
    Force pseudo-terminal allocation.

#### 14.

```sudo echo string > /root/new_file```
выкидывает ошибку доступа, потому что оболочка, текущая оболочка запущена не из под root пользоветля

```echo string | sudo tee /root/new_file```
предполагаю, что создает собственный экземпляр оболочки, поскольку сама команда способна читать input, выводить его в stdout
и , одновременно, записывать его в файл


