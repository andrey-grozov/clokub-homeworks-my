locals {
  zone = "ru-central1-a"
  nat_image_id = "fd80mrhj8fl2oe87o4e1"
  public_subnet = ["192.168.10.0/24"]
  private_subnet = ["192.168.20.0/24"]
  nat_gw = "192.168.10.254"
}

provider "yandex" {
  token = "${var.yc_token}"
  cloud_id = "b1gm3i0j5l43veldtm5i"
  folder_id = "b1gjnqmnsgukunj8khak"
  zone = local.zone
}

# Ubuntu 20-04 image
data "yandex_compute_image" "linux" {
  family = "ubuntu-2004-lts"
}

# Создаем VPC.
resource "yandex_vpc_network" "vpc-my" {
  name = "vpc-netology-my"
}

# Создаем route table.
resource "yandex_vpc_route_table" "via-nat" {
  network_id = yandex_vpc_network.vpc-my.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = local.nat_gw
  }
}

# Создаемsubnet public (192.168.10.0/24).
resource "yandex_vpc_subnet" "public" {
  v4_cidr_blocks = local.public_subnet
  zone = local.zone
  network_id = yandex_vpc_network.vpc-my.id
}

# Создаемsubnet private (192.168.20.0/24).
resource "yandex_vpc_subnet" "private" {
  v4_cidr_blocks = local.private_subnet
  zone = local.zone
  network_id = yandex_vpc_network.vpc-my.id
  route_table_id = yandex_vpc_route_table.via-nat.id
}

# NAT instance
resource "yandex_compute_instance" "nat-instance" {
  name = "nat-instance"
  hostname = "nat-instance"

  resources {
    cores = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = local.nat_image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = local.nat_gw
    nat = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


# public и privat VMs
resource "yandex_compute_instance" "test-public" {
  name = "test-public"
  hostname = "test-public"

  resources {
    cores = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.linux.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "test-private" {
  name = "test-private"
  hostname = "test-private"

  resources {
    cores = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.linux.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
