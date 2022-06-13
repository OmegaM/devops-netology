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


resource "yandex_lb_network_load_balancer" "group_load_balancer" {
  name = "group-balancer"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.lamp_group.load_balancer.0.target_group_id}"

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
