variable "vm" {
  type = map(object({
    vm_name             = string
    vm_nic              = string
    resource_group_name = string
    location            = string
    subnet_id           = string
  }))
}

variable "key_vault_name" {
  type = string
}

variable "key_vault_resource_group_name" {
  type = string
}

variable "username_secret_name" {
  type = string
}

variable "password_secret_name" {
  type = string
}