# 3.5. Файловые системы

#### 2.
```
vagrant@vagrant:~$ touch link_test
vagrant@vagrant:~$ ll -i
...
2883589 -rw-rw-r-- 1 vagrant vagrant     0 Jun  9 04:43 link_test
...
vagrant@vagrant:~$ ln -P link_test hard_link
vagrant@vagrant:~$ ll -i
...
2883589 -rw-rw-r-- 2 vagrant vagrant     0 Jun  9 04:43 hard_link
2883589 -rw-rw-r-- 2 vagrant vagrant     0 Jun  9 04:43 link_test
...
vagrant@vagrant:~$ sudo chown root:root hard_link
vagrant@vagrant:~$ ll
...
-rw-rw-r-- 2 root    root        0 Jun  9 04:43 hard_link
-rw-rw-r-- 2 root    root        0 Jun  9 04:43 link_test
...
vagrant@vagrant:~$ ln -P link_test hard_link1
ln: failed to create hard link 'hard_link1' => 'link_test': Operation not permitted
vagrant@vagrant:~$ sudo !!
sudo ln -P link_test hard_link1
vagrant@vagrant:~$ ll
...
-rw-rw-r-- 3 root    root        0 Jun  9 04:43 hard_link
-rw-rw-r-- 3 root    root        0 Jun  9 04:43 hard_link1
-rw-rw-r-- 3 root    root        0 Jun  9 04:43 link_test
...
vagrant@vagrant:~$ chown vagrant:vagrant hard_link1
chown: changing ownership of 'hard_link1': Operation not permitted
vagrant@vagrant:~$ sudo !!
sudo chown vagrant:vagrant hard_link1
vagrant@vagrant:~$ ll
...
-rw-rw-r-- 3 vagrant vagrant     0 Jun  9 04:43 hard_link
-rw-rw-r-- 3 vagrant vagrant     0 Jun  9 04:43 hard_link1
-rw-rw-r-- 3 vagrant vagrant     0 Jun  9 04:43 link_test
...
```

#### 4.
```
vagrant@vagrant:~$ sudo fdisk -l
...
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
...
vagrant@vagrant:~$ sudo fdisk /dev/sdb

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): e
Partition number (1-4, default 1):
First sector (2048-5242879, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Extended' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (0 primary, 1 extended, 3 free)
   l   logical (numbered from 5)
Select (default p): p
Partition number (2-4, default 2):
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

vagrant@vagrant:~$ sudo fdisk /dev/sdb -l
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xaa2ca24b

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G  5 Extended
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux
```
#### 5.
```
vagrant@vagrant:~$ sudo sfdisk -d /dev/sdb > sdb_dump
vagrant@vagrant:~$ cat sdb_dump
label: dos
label-id: 0xaa2ca24b
device: /dev/sdb
unit: sectors

/dev/sdb1 : start=        2048, size=     4194304, type=5
/dev/sdb2 : start=     4196352, size=     1046528, type=83
vagrant@vagrant:~$ sudo sfdisk /dev/sdc < sdb_dump
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xaa2ca24b

Old situation:

Device     Boot Start     End Sectors Size Id Type
/dev/sdc1        2048 4196351 4194304   2G  5 Extended

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xaa2ca24b.
/dev/sdc1: Created a new partition 1 of type 'Extended' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0xaa2ca24b

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G  5 Extended
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
vagrant@vagrant:~$ sudo fdisk -l /dev/sdc
Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xaa2ca24b

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G  5 Extended
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux
```
#### 6.
```
root@vagrant:/home/vagrant# mdadm --create /dev/md0 --verbose -l 1 -n 2 /dev/sdb1 /dev/sdc1
mdadm: partition table exists on /dev/sdb1
mdadm: partition table exists on /dev/sdb1 but will be lost or
       meaningless after creating array
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: partition table exists on /dev/sdc1
mdadm: partition table exists on /dev/sdc1 but will be lost or
       meaningless after creating array
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
root@vagrant:/home/vagrant# ll /dev/ | grep md
brw-rw----  1 root    disk      9,   0 Jun  9 09:37 md0
```
#### 7.
```
root@vagrant:/home/vagrant# mdadm --create /dev/md1 --verbose -l 0 -n 2 /dev/sd{b,c}2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
root@vagrant:/home/vagrant# ll /dev/ | grep md
brw-rw----  1 root    disk      9,   1 Jun  9 09:38 md1
```
#### 8.
```
root@vagrant:/home/vagrant# pvs
  PV         VG        Fmt  Attr PSize   PFree
  /dev/sda5  vgvagrant lvm2 a--  <63.50g    0
root@vagrant:/home/vagrant# pvcreate /dev/md{0,1}
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.
root@vagrant:/home/vagrant# pvs
  PV         VG        Fmt  Attr PSize    PFree
  /dev/md0             lvm2 ---    <2.00g   <2.00g
  /dev/md1             lvm2 ---  1018.00m 1018.00m
  /dev/sda5  vgvagrant lvm2 a--   <63.50g       0
```
#### 9.
```
root@vagrant:/home/vagrant# vgcreate vg0 /dev/md{0,1}
  Volume group "vg0" successfully created
root@vagrant:/home/vagrant# vgs
  VG        #PV #LV #SN Attr   VSize   VFree
  vg0         2   0   0 wz--n-  <2.99g <2.99g
  vgvagrant   1   2   0 wz--n- <63.50g     0
```
#### 10.
```
root@vagrant:/home/vagrant# lvcreate -L100M -n lv0 vg0 /dev/md1
  Logical volume "lv0" created.
root@vagrant:/home/vagrant# lvs
  LV     VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lv0    vg0       -wi-a----- 100.00m
  root   vgvagrant -wi-ao---- <62.54g
  swap_1 vgvagrant -wi-ao---- 980.00m
```
#### 11.
```
root@vagrant:/home/vagrant# lvdisplay
...
  --- Logical volume ---
  LV Path                /dev/vg0/lv0
  LV Name                lv0
  VG Name                vg0
  LV UUID                wpx8Sn-c0cZ-EKnn-pcl0-GFdL-wItf-2hdsMs
  LV Write Access        read/write
  LV Creation host, time vagrant, 2021-06-09 13:03:52 +0000
  LV Status              available
  # open                 0
  LV Size                100.00 MiB
  Current LE             25
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     4096
  Block device           253:2

root@vagrant:/home/vagrant# mkfs.ext4 -L fk0 /dev/vg0/lv0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```
#### 12.
```
root@vagrant:/home/vagrant# mkdir /tmp/new
root@vagrant:/home/vagrant# mount /dev/vg0/lv0 /tmp/new/
```
#### 13.
```
root@vagrant:/tmp/new# cp /etc/hosts /tmp/new/test.gz
root@vagrant:/tmp/new# ll
...
-rw-r--r--  1 root root   198 Jun  9 13:25 test.gz
```
#### 14.
```
root@vagrant:/tmp/new# lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─vg0-lv0        253:2    0  100M  0 lvm   /tmp/new
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─vg0-lv0        253:2    0  100M  0 lvm   /tmp/new
```
#### 15.
```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```
#### 16.
```
root@vagrant:~# pvmove /dev/md1 /dev/md0
  /dev/md1: Moved: 100.00%
```
#### 17.
```
root@vagrant:~# mdadm --fail /dev/md0 /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0
root@vagrant:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md1 : active raid0 sdc2[1] sdb2[0]
      1042432 blocks super 1.2 512k chunks

md0 : active raid1 sdc1[1] sdb1[0](F)
      2094080 blocks super 1.2 [2/1] [_U]

unused devices: <none>
```
#### 18.
```
[16726.568621] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
```
#### 19.
```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```