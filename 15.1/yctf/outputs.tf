output "test_public_ip" {
  description = "Test public IP"
  value = yandex_compute_instance.test-public.network_interface.0.nat_ip_address
}

output "test_private_ip" {
  description = "Test private IP"
  value = yandex_compute_instance.test-private.network_interface.0.ip_address
}

output "public_nat_ip" {
  description = "Public NAT IP"
  value = yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address
}
