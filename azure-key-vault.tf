provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "key_vault_rg" {
  name     = "key-vault-rg"
  location = "East US"
}

resource "azurerm_key_vault" "key_vault" {
  name                = "myuniquekeyvaultname" # Ensure this name is globally unique
  location            = azurerm_resource_group.key_vault_rg.location
  resource_group_name = azurerm_resource_group.key_vault_rg.name
  sku_name           = "standard"

  tenant_id = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["get", "list"]
    secret_permissions = ["get", "list", "set", "delete"]
    certificate_permissions = []
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "example_secret" {
  name         = "example-secret"
  value        = "supersecretvalue"
  key_vault_id = azurerm_key_vault.key_vault.id
}

output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
  description = "The ID of the Key Vault"
}

output "key_vault_uri" {
  value = azurerm_key_vault.key_vault.vault_uri
  description = "The URI of the Key Vault"
}