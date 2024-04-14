resource "yandex_compute_instance" "server" {
    for_each = { for inst in var.arturas_servers : inst.name => inst }
    name = "${each.value.name}"
    hostname = "${each.value.name}"
    zone = var.arturas_zone
    platform_id = "standard-v2"

    metadata = {
        ssh-keys = "${file("ssh-public-keys.txt")}"
    }

    resources {
        cores = "${each.value.cores}"
        core_fraction = "${each.value.fractions}"
        memory = "${each.value.memory}"
    }

    boot_disk {
        initialize_params {
            image_id = "fd866d9q7rcg6h4udadk" # Ubuntu 22.04 LTS
            size = 20
        }
    }

    network_interface {
        subnet_id = var.arturas_subnet
        nat = true
    }

    scheduling_policy {
        preemptible = true
    }
}
