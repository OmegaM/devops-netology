resource "yandex_compute_instance" "master" {
    count     = var.master_count
    name      = "master-${count.index}"

    resources {
        cores     = var.master_instance.core
        memory    = var.master_instance.ram
    }

    boot_disk {
        initialize_params {
            image_id    = var.master_instance.image_id
            size        = var.master_instance.disk
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
  }

  metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker" {
    count = var.worker_count
    name = "worker-${count.index}"

    resources {
        cores   = var.worker_instance.core
        memory  = var.worker_instance.ram
    }

    boot_disk {
        initialize_params {
            image_id    = var.worker_instance.image_id
            size        = var.worker_instance.disk
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
    }
    
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}