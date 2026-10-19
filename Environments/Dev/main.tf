module "rg" {
  source = "../../child_modules/azurerm_resource_group"

  rg = {
    dev = {
      name     = "dev-san-rg"
      location = "eastus"
    }
  }
}

module "vnet" {
  source = "../../child_modules/azurerm_Virtual_network"

  vnet = {
    dev = {
      name                = "dev-san-vnet"
      location            = "eastus"
      resource_group_name = "dev-san-rg"
      address_space       = ["10.0.0.0/16"]
    }
  }

  depends_on = [module.rg]
}

module "subnet" {
  source = "../../child_modules/azurerm_subnet"

  subnet = {
    vm = {
      name                 = "dev-vm-subnet"
      resource_group_name  = "dev-san-rg"
      virtual_network_name = "dev-san-vnet"
      address_prefixes     = ["10.0.1.0/24"]
    }
    bastion = {
      name                 = "AzureBastionSubnet"
      resource_group_name  = "dev-san-rg"
      virtual_network_name = "dev-san-vnet"
      address_prefixes     = ["10.0.2.0/26"]
    }
  }

  depends_on = [module.vnet]
}

module "storage_account" {
  source = "../../child_modules/azurerm_storage_account"

  storage = {
    dev = {
      name                     = "devsanstg20261018"
      resource_group_name      = "dev-san-rg"
      location                 = "eastus"
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
  }

  depends_on = [module.rg]
}

module "bastion" {
  source = "../../child_modules/azurerm_bastion"

  bastion = {
    dev = {
      bastion             = "dev-san-bastion"
      pip_name            = "dev-san-bastion-pip"
      location            = "eastus"
      resource_group_name = "dev-san-rg"
      subnet_id           = module.subnet.subnet_ids["bastion"]
    }
  }
}

module "vm" {
  source = "../../child_modules/azurerm_Virtual_machine"

  vm = {
    dev = {
      vm_name             = "dev-san-vm"
      vm_nic              = "dev-san-vm-nic"
      resource_group_name = "dev-san-rg"
      location            = "eastus"
      subnet_id           = module.subnet.subnet_ids["vm"]
    }
  }

  key_vault_name                = "Alibabakhajana"
  key_vault_resource_group_name = "rg-terraform-demo"
  username_secret_name          = "vmusername"
  password_secret_name          = "vmpassword"
}
