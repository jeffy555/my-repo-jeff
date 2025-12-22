provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_container_registry" "main" {
  name                = "mycontainerregistry"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"

  admin_enabled = true

  tags = {
    environment = "production"
  }
}

output "container_registry_login_server" {
  value = azurerm_container_registry.main.login_server
}

output "container_registry_admin_username" {
  value = azurerm_container_registry.main.admin_username
}

output "container_registry_admin_password" {
  value = azurerm_container_registry.main.admin_password
}