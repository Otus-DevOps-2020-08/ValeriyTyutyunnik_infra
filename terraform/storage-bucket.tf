terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "tf-state-storage"
    region                      = "ru-central1"
    key                         = "terraform.tfstate"
    access_key                  = "i3UztEgRXM7it5Ve1D7d"
    secret_key                  = "FfDc8rbrl0F8eP2MaQvI36pjJ9VJk-otYAfBnN04"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
