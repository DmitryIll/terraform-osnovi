output "app_external-platform" {
   value="vm_web IP (yandex_compute_instance.platform):${yandex_compute_instance.platform.network_interface.0.nat_ip_address} \n fqdn: ${yandex_compute_instance.platform.fqdn} \n \n  vm_db IP (yandex_compute_instance.db): ${yandex_compute_instance.db.network_interface.0.nat_ip_address} \n fqdn: ${yandex_compute_instance.db.fqdn}"
}

# output "app_external-db" {
#    value="${yandex_compute_instance.db.network_interface.0.nat_ip_address}"
# }


# output "internal-ip" {
#    value="${yandex_compute_instance.db.network_interface.0.ip_address}"
# }
