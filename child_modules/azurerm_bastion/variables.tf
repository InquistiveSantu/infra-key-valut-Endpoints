variable "bastion" {
  type = map(object({
    bastion             = string
    pip_name            = string
    location            = string
    resource_group_name = string
    subnet_id           = string
  }))
}