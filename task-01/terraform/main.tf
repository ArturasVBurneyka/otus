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

resource "yandex_compute_instance" "firstserver" {
    name = "arturas-server-01"
    hostname = "arturas-server-01"
    zone = var.arturas_zone
    platform_id = "standard-v1" # Intel Broadwell, Intel Xeon Processor E5 2660v4 35m Cache 2GHz

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
            image_id = "fd808e721rc1vt7jkd0o" # Ubuntu 20.04 LTS
            size = 16
        }
    }

    network_interface {
        subnet_id = var.arturas_subnet
        nat = true
    }

    connection {
        type = "ssh"
        user = var.arturas_user
        host = yandex_compute_instance.firstserver.network_interface.0.nat_ip_address
    }

    provisioner "remote-exec" {
        inline = [ "sudo apt-get update" ]
    }

    provisioner "local-exec" {
        command = "ansible-playbook --ask-become-pass --inventory '${yandex_compute_instance.firstserver.network_interface.0.nat_ip_address},' --user ${var.arturas_user} ../ansible/playbook.yaml"
    }
}

output "name" {
    value = yandex_compute_instance.firstserver.name
}

output "address" {
    value = yandex_compute_instance.firstserver.network_interface.0.nat_ip_address
}
