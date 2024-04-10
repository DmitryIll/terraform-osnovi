resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "db" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_cidr
}

resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id      = var.folder_id
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  folder_id      = var.folder_id
  name       = "test-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

data "yandex_compute_image" "ubuntu" {
  # family = "ubuntu-2004-lts"
  family = var.vm_web_family


}
resource "yandex_compute_instance" "platform" {
  # name        = "netology-develop-platform-web"
  # name        = var.vm_web_name
  name           = local.name-web
  
  # platform_id = "standard-v1"
  platform_id = var.vm_web_standard

  resources { 
    
    # cores         = 4
    # cores         = var.vm_web_cores
    cores           = var.vms_resources.web.cores

    # memory        = 4
    # memory        = var.vm_web_memory
    memory          = var.vms_resources.web.memory
    
    # core_fraction = 100
    # core_fraction = var.vm_web_fraction
    core_fraction = var.vms_resources.web.core_fraction

  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    # preemptible = true
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    # nat       = true
    nat       = var.vm_web_nat
  }

  metadata = var.metadata
  #  {
  #   # serial-port-enable = 1
  #   serial-port-enable = var.vm_web_sp

  #   ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  # }

}


# -------------------------

resource "yandex_compute_instance" "db" {
  # name        = "netology-develop-platform-web"
  # name        = var.vm_db_name
  name          = local.name-db
  zone        = var.vm_db_zone
  
  # platform_id = "standard-v1"
  platform_id = var.vm_db_standard

  resources { 
    # cores         = 4
    # cores         = var.vm_db_cores

    # memory        = 4
    # memory        = var.vm_db_memory
    
    # core_fraction = 100
    # core_fraction = var.vm_db_fraction

    cores           = var.vms_resources.db.cores
    memory          = var.vms_resources.db.memory
    core_fraction   = var.vms_resources.db.core_fraction


  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    # preemptible = true
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    #subnet_id = yandex_vpc_subnet.develop.id
    subnet_id = yandex_vpc_subnet.db.id
    # nat       = true
    nat       = var.vm_db_nat
  }

  metadata = var.metadata
  
  #  {
  #   # serial-port-enable = 1
  #   serial-port-enable = var.vm_db_sp

  #   ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  # }

}