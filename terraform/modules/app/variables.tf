variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable subnet_id {
  description = "Subnets for modules"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable db_ip_address {
  description = "Database ip address"
}

variable instance_count {
  description = "How many instances should be created"
  type        = number
  default     = 1
}

variable use_provisioner {
  description = "False will disable provisioners"
  type        = bool
  default     = true
}
