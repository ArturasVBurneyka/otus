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
    for_each = { for inst in var.arturas_servers : inst.name => inst }
    name = "${each.value.name}"
    hostname = "${each.value.name}"
    zone = var.arturas_zone
    platform_id = "standard-v2"

    metadata = {
        ssh-keys = "${var.arturas_user}:${var.arturas_ssh_public_key}"
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
}
