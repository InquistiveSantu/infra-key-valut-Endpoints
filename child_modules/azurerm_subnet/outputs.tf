output "subnet_ids" {
  value = {
    for key, subnet in azurerm_subnet.subnetblock : key => subnet.id
  }
}
