variable "YA_TOKEN" {
    type = string
}

variable "CLOUD_ID"{
    type = string
}

variable "FOLDER_ID"{
    type = string
}

variable "master_instance"{
    type    = object({
        core    = number
        ram     = number
        disk    = number 
        image_id= string
    })
    default = {
        core    = 4
        ram     = 4
        disk    = 50
        image_id= "fd8mfc6omiki5govl68h"
    }
}

variable "master_count" {
    type = number
    default = 0
}

variable "worker_instance"{
    type    = object({
        core    = number
        ram     = number
        disk    = number
        image_id= string
    })
    default = {
        core    = 2
        ram     = 2
        disk    = 100
        image_id="fd8mfc6omiki5govl68h"
    }
}

variable "worker_count"{
    type =  number
    default = 0
}