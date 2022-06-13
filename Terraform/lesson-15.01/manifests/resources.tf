resource "yandex_vpc_network" "block-15" {
    name            = "block-15"
}

resource "yandex_vpc_subnet" "subnets" {
    for_each        = { for sn in var.SUBNETS : sn.name => sn }

    name            = "${each.value.name}"
    v4_cidr_blocks  = "${each.value.cidr_block}"

    network_id      = "${yandex_vpc_network.block-15.id}"
    zone            = var.ZONE
}

resource "yandex_vpc_route_table" "private_subnet_nat_route" {
  network_id = "${yandex_vpc_network.block-15.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

resource "yandex_compute_instance" "nat_instance" {
    name            = "nat-instance"
    zone            = var.ZONE

    resources {
        cores           = 2
        memory          = 1
        core_fraction   = 20
    }

    boot_disk {
        initialize_params {
            image_id    = "fd80mrhj8fl2oe87o4e1"
        }
    }

    network_interface {
        subnet_id       = "${yandex_vpc_subnet.subnets["public"].id}"
        nat_ip_address  = "192.168.10.254" 
    }
}

resource "yandex_compute_instance" "tmp_vm" {
    for_each    = {for tmp in var.TMP_VMS : tmp.name => tmp}

    name        = "${each.value.name}"
    zone        = var.ZONE

    metadata = {
        ssh-keys= "${each.value.user_name}:${file("~/.ssh/id_rsa.pub")}"
    }

    resources {
        cores           = "${each.value.cpu}"
        memory          = "${each.value.ram}"
        core_fraction   = 20  
    }

    boot_disk {
        initialize_params {
            image_id    = "${each.value.image_id}"
        }
    }

     network_interface {
        subnet_id       = "${yandex_vpc_subnet.subnets["${each.value.subnet_name}"].id}"
        nat             = "${each.value.nat}"
    }
}
