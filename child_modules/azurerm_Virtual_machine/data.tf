data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}


data "azurerm_key_vault_secret" "username" {
  name         = var.username_secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "password" {
  name         = var.password_secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}