output "external_ip_address_app" {
  description = "IP address of the reddit-app instances."
  value       = yandex_compute_instance.app.*.network_interface.0.nat_ip_address
}
