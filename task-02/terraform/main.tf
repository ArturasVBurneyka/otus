terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
}

provider "yandex" {
    token = var.arturas_oauth_token
    cloud_id = var.arturas_cloud_id
    folder_id = var.arturas_folder_id
    zone = var.arturas_zone
}

resource "yandex_compute_instance" "server" {
    for_each = var.arturas_servers
    name = "${each.value}"
    hostname = "${each.value}"
    zone = var.arturas_zone
    platform_id = "standard-v2"

    metadata = {
        ssh-keys = "${var.arturas_user}:${var.arturas_ssh_public_key}"
    }

    resources {
        cores = 2
        core_fraction = 5
        memory = 1
    }

    boot_disk {
        initialize_params {
            image_id = "fd8kcnjakd0m6hsg8vi7" # Ubuntu 18.04 LTS
            size = 20
        }
    }

    network_interface {
        subnet_id = var.arturas_subnet
        nat = true
    }
}

output "names" {
    value = [ for s in yandex_compute_instance.server : s.name ]
}

output "addresses" {
    value = [ for s in yandex_compute_instance.server : s.network_interface.0.nat_ip_address ]
}
