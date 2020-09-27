output "external_ip_address_app" {
  description = "IP address of the reddit-app instances."
  value       = yandex_compute_instance.app.*.network_interface.0.nat_ip_address
}

output "external_ip_address_lb" {
  description = "IP address of the load balancer for reddit-app"
  value       = yandex_lb_network_load_balancer.load_balancer.listener
}
