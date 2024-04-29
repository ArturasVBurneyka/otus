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

variable "arturas_servers" {
    type = list(object({
        name        = string
        cores       = number
        fractions   = number
        memory      = number
    }))
    default = [
        {
            name        = "kubernetes-master-1st"
            cores       = 2
            fractions   = 5
            memory      = 2
        },
        {
            name        = "kubernetes-master-2nd"
            cores       = 2
            fractions   = 5
            memory      = 2
        },
        {
            name        = "kubernetes-master-3rd"
            cores       = 2
            fractions   = 5
            memory      = 2
        },
        {
            name        = "kubernetes-worker-1st"
            cores       = 2
            fractions   = 5
            memory      = 2
        },
        {
            name        = "kubernetes-worker-2nd"
            cores       = 2
            fractions   = 5
            memory      = 2
        },
        {
            name        = "kubernetes-worker-3rd"
            cores       = 2
            fractions   = 5
            memory      = 2
        }
    ]
}
