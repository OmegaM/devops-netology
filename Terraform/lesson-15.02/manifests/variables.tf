variable "ZONE" {
    type    = string
    default = "ru-central1-a"
}

variable "SUBNETS" {
    type    = list(object({
        name        = string
        type        = string
        cidr_block  = list(string)
    }))

    default = [
        {
            name        = "private"
            type        = "private"
            cidr_block  = ["192.168.20.0/24"]
        },
        {
            name        = "public"
            type        = "public"
            cidr_block  = ["192.168.10.0/24"]
        }
    ]
}

variable "TMP_VMS" {
    type = list(object({
        name        = string
        count       = number
        image_id    = string
        cpu         = number
        ram         = number
        subnet_name = string
        user_name   = string
        nat         = bool
    }))

    default = [
        {
            name        = "public-tmp-vm"
            count       = 0
            image_id    = "fd8ad4ie6nhfeln6bsof" #Centos 7
            cpu         = 2
            ram         = 1
            subnet_name = "public"
            user_name   = "centos"
            nat         = true
        },
        {
            name        = "private-tmp-vm"
            count       = 0
            image_id    = "fd8ad4ie6nhfeln6bsof" #Centos 7
            cpu         = 2
            ram         = 1
            subnet_name = "private"
            user_name   = "centos"
            nat         = false
        },
        {
            name        = "lamp_template"
            count       = 0
            image_id    = "fd827b91d99psvq5fjit" #LAMP
            cpu         = 2
            ram         = 2
            subnet_name = "public"
            user_name   = "ubuntu"
            nat         = true
            
        }
    ]
    description     = "Count and types of temrorarry VMs"
}

variable "FOLDER" {}
