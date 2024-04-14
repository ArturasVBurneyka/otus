variable "arturas_oauth_token" {
    type = string
}

variable "arturas_cloud_id" {
    type = string
}

variable "arturas_folder_id" {
    type = string
}

variable "arturas_zone" {
    type = string
}

variable "arturas_subnet" {
    type = string
}

variable "arturas_user" {
    type = string
}

variable "arturas_ssh_public_key" {
    type = string
}

variable "arturas_servers" {
    type = list(object({
        name        = string
        cores       = number
        fractions   = number
        memory      = number
    }))
    default = [
        {
            name        = "k3s-master"
            cores       = 2
            fractions   = 5
            memory      = 2
        },
        {
            name        = "k3s-worker-first"
            cores       = 2
            fractions   = 5
            memory      = 2
        },
        {
            name        = "k3s-worker-second"
            cores       = 2
            fractions   = 5
            memory      = 2
        }
    ]
}
