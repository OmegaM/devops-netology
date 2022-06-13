output "nat_instance_internal_ip" {
    value = yandex_compute_instance.nat_instance.network_interface.*.ip_address
}

output "nat_instance_external_ip" {
    value = yandex_compute_instance.nat_instance.network_interface.*.nat_ip_address
}

output "tmp_external_ips" {
    value = values(yandex_compute_instance.tmp_vm).*.network_interface.0.nat_ip_address
}

output "tmp_intenal_ips" {
    value = values(yandex_compute_instance.tmp_vm).*.network_interface.0.ip_address
}