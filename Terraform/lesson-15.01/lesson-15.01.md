# 15.1. Организация сети

#### 1.
```bash
 # yandex_vpc_network.block-15 will be created
  + resource "yandex_vpc_network" "block-15" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "block-15"
      + subnet_ids                = (known after apply)
    }

```
#### 2.
```bash
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.nat_instance will be created
  + resource "yandex_compute_instance" "nat_instance" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + name                      = "nat-instance"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd80mrhj8fl2oe87o4e1"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = (known after apply)
          + nat_ip_address     = "192.168.10.254"
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

   # yandex_compute_instance.tmp_vm["public-tmp-vm"] will be created
  + resource "yandex_compute_instance" "tmp_vm" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCxDhg6n+T+x2tZ6Bf55jz37bRBI9sXsK/lGY4nG3sludcvKf6xkWMBAA4NwBkLwR0ZxDLIJmo88z8XRmJNBE3OjavtcBv+rscjBOMYKLrToaKE1D7qT9lWs8RHGrgu1UTAx/YhSCYzIrcTfcft2iUTPlbRhURxkZnKKvhttJZe4gv4llEeghiyOhdKAHrAiTShqo4wCt1EExOT/8UwsBAST1H3O3WYsTWyYtz6LQ2w/Ck5eEiq3In47P6EFaNCk2Hy7Y1cbfFhFRMKWPfuAGzTiWBwwt6mmWFNAl7gukf/OkLCWXn8xcyuNpuzhFbXVYZoSP7PsERpXGJTwHFABk5HQJ/Up7wKc5gXI/iky1CfiS6fhk5Icb+gH0vpXIut8FHqH5BBPzJbvBklvumKAIlA/k+kllOvEPnGKbyj/cDVjm4B8a/aOuDpT33N/3/7ZU/VB0Rf7IboSY+LVqBwUsBf3lttGxZweL0q3ofsbbLG2fghX5sx6pY3n8D+Nocbjk= omi@MSKESO-V00015
            EOT
        }
      + name                      = "public-tmp-vm"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8ad4ie6nhfeln6bsof"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = "e9b854havhhrm5dhjl9g"
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_subnet.subnets["public"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "public"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + nat_instance_external_ip = [
      + "192.168.10.254",
    ]
  + nat_instance_internal_ip = [
      + (known after apply),
    ]
  + tmp_external_ips         = [
      + (known after apply),
    ]
  + tmp_intenal_ips          = [
      + (known after apply),
    ]
```

```bash
$ ssh centos@51.250.68.142
The authenticity of host '51.250.68.142 (51.250.68.142)' can't be established.
ECDSA key fingerprint is SHA256:wikcQUkn+ODnmIFzk7sA9xwN/U3afGoR7n+r1DUpHfo.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '51.250.68.142' (ECDSA) to the list of known hosts.
[centos@fhm8vv945lecglr51phi ~]$ ping google.com
PING google.com (74.125.205.138) 56(84) bytes of data.
64 bytes from le-in-f138.1e100.net (74.125.205.138): icmp_seq=1 ttl=61 time=24.5 ms
64 bytes from le-in-f138.1e100.net (74.125.205.138): icmp_seq=2 ttl=61 time=23.7 ms
64 bytes from le-in-f138.1e100.net (74.125.205.138): icmp_seq=3 ttl=61 time=23.8 ms
64 bytes from le-in-f138.1e100.net (74.125.205.138): icmp_seq=4 ttl=61 time=23.8 ms
^C
--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3006ms
rtt min/avg/max/mdev = 23.787/24.007/24.510/0.330 ms
```
#### 3.
```bash
# yandex_vpc_subnet.subnets["private"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "private"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.20.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }
# yandex_vpc_route_table.private_subnet_nat_route will be created
  + resource "yandex_vpc_route_table" "private_subnet_nat_route" {
      + created_at = (known after apply)
      + folder_id  = (known after apply)
      + id         = (known after apply)
      + labels     = (known after apply)
      + network_id = "enppqnguuev58ns43fe3"

      + static_route {
          + destination_prefix = "192.168.20.0/24"
          + next_hop_address   = "192.168.10.254"
        }
    }

# yandex_compute_instance.tmp_vm["private-tmp-vm"] will be created
  + resource "yandex_compute_instance" "tmp_vm" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCxDhg6n+T+x2tZ6Bf55jz37bRBI9sXsK/lGY4nG3sludcvKf6xkWMBAA4NwBkLwR0ZxDLIJmo88z8XRmJNBE3OjavtcBv+rscjBOMYKLrToaKE1D7qT9lWs8RHGrgu1UTAx/YhSCYzIrcTfcft2iUTPlbRhURxkZnKKvhttJZe4gv4llEeghiyOhdKAHrAiTShqo4wCt1EExOT/8UwsBAST1H3O3WYsTWyYtz6LQ2w/Ck5eEiq3In47P6EFaNCk2Hy7Y1cbfFhFRMKWPfuAGzTiWBwwt6mmWFNAl7gukf/OkLCWXn8xcyuNpuzhFbXVYZoSP7PsERpXGJTwHFABk5HQJ/Up7wKc5gXI/iky1CfiS6fhk5Icb+gH0vpXIut8FHqH5BBPzJbvBklvumKAIlA/k+kllOvEPnGKbyj/cDVjm4B8a/aOuDpT33N/3/7ZU/VB0Rf7IboSY+LVqBwUsBf3lttGxZweL0q3ofsbbLG2fghX5sx6pY3n8D+Nocbjk= omi@MSKESO-V00015
            EOT
        }
      + name                      = "private-tmp-vm"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8ad4ie6nhfeln6bsof"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = "e9bi55566q2khg5v6kaa"
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

```
```bash
 scp /home/omi/.ssh/id_rsa.pub centos@51.250.95.52:~/.ssh/
id_rsa.pub

[centos@fhmn8vrib6l4uiebps77 ~]$ ssh 192.168.20.31
The authenticity of host '192.168.20.31 (192.168.20.31)' can't be established.
ECDSA key fingerprint is SHA256:gsZqqt3X4uUaCgJ5LvzMH8WYzLnCLpazT8YZui5GbA8.
ECDSA key fingerprint is MD5:f9:f6:77:32:ca:60:d7:a0:c6:3a:63:28:d6:e1:f0:74.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.20.31' (ECDSA) to the list of known hosts.
Permission denied (publickey,gssapi-keyex,gssapi-with-mic).

[centos@fhmn8vrib6l4uiebps77 ~]$ ping google.com
PING google.com (74.125.131.113) 56(84) bytes of data.
64 bytes from lu-in-f113.1e100.net (74.125.131.113): icmp_seq=1 ttl=61 time=21.6 ms
64 bytes from lu-in-f113.1e100.net (74.125.131.113): icmp_seq=2 ttl=61 time=21.2 ms
64 bytes from lu-in-f113.1e100.net (74.125.131.113): icmp_seq=3 ttl=61 time=21.2 ms
^C
--- google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 21.202/21.371/21.658/0.204 ms

[centos@fhmn8vrib6l4uiebps77 ~]$ curl google.com
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
```