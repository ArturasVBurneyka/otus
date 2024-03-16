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
