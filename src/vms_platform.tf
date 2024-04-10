variable test {
  type = list(map(list(string)))
  default = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
}


 

variable "vms_resources" {
  default = {
     web={
       cores=4
       memory=4
       core_fraction=100
     },
     db= {
       cores=2
       memory=2
       core_fraction=20
     }
  }
}

variable   "metadata"  {
  default = {
     serial-port-enable = 1
     ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHgAWJRB1phor3yFZd/GZBaVIZUzYc8KyrpSzQnEH7lJ user@worknout"
   }
}


variable "vm_db_vpc_name" {
  type        = string
  default     = "db"
  description = "VPC network & subnet name for db"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


variable "vm_web_family" {
  type = string
  default ="ubuntu-2004-lts"
}

variable "vm_web_name" {
  type = string
  default ="netology-develop-platform-web"
}

variable "vm_web_standard" {
  type = string
  default = "standard-v1"
}

# variable "vm_web_cores" {
#   type = number
#   default = 4
# }

# variable "vm_web_memory" {
#   type = number
#   default = 4
# }

# variable "vm_web_fraction" {
#   type = number
#   default = 100
# }

variable "vm_web_preemptible" {
  type = bool 
  default = true
}

variable "vm_web_nat" {
  type = bool
  # default = true
  default = false
}

variable "vm_web_sp" {
  type = number
  default = 1
}

# ----------

# ВМ должна работать в зоне "ru-central1-b"


variable "vm_db_zone" {
  type = string
  default = "ru-central1-b"
}

variable "vm_db_family" {
  type = string
  default ="ubuntu-2004-lts"
}

variable "vm_db_name" {
  type = string
  default ="netology-develop-platform-db"
}

variable "vm_db_standard" {
  type = string
  default = "standard-v1"
}

# variable "vm_db_cores" {
#   type = number
#   default = 2
# }

# variable "vm_db_memory" {
#   type = number
#   default = 2
# }

# variable "vm_db_fraction" {
#   type = number
#   default = 20
# }

variable "vm_db_preemptible" {
  type = bool 
  default = true
}

variable "vm_db_nat" {
  type = bool
  default = true
}

variable "vm_db_sp" {
  type = number
  default = 1
}