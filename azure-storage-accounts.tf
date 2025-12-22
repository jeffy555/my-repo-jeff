provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "storage_rg" {
  name     = "storage-resource-group"
  location = "East US"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "mystorageaccount${count.index}"
  resource_group_name      = azurerm_resource_group.storage_rg.name
  location                 = azurerm_resource_group.storage_rg.location
  account_tier             = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  tags = {
    environment = "production"
    project     = "unstructured-data-storage"
  }
}

output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
  sensitive = true
}