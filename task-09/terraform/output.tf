output "names" {
    value = [ for s in yandex_compute_instance.server : s.name ]
}

output "addresses" {
    value = [ for s in yandex_compute_instance.server : s.network_interface.0.nat_ip_address ]
}
