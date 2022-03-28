
output "internal_ip_master" {
  value = yandex_compute_instance.master[*].network_interface.0.ip_address
}

output "internal_ip_worker" {
  value = yandex_compute_instance.worker[*].network_interface.0.ip_address
}


output "external_ip_master" {
  value = yandex_compute_instance.master[*].network_interface.0.nat_ip_address
}

output "external_ip_worker" {
  value = yandex_compute_instance.worker[*].network_interface.0.nat_ip_address
}