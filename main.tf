provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "function_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "function_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.function_rg.name
  location                 = azurerm_resource_group.function_rg.location
  account_tier            = "Standard"
  account_replication_type = "LRS"
  min_tls_version         = "TLS1_2" // Ensure the latest version of TLS encryption
  allow_blob_public_access = false    // Disallow public access
}

resource "azurerm_app_service_plan" "function_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.function_rg.location
  resource_group_name = azurerm_resource_group.function_rg.name
  sku {
    tier     = "Dynamic"
    size     = "Y1"
  }
}

resource "azurerm_function_app" "function_app" {
  name                       = var.function_app_name
  location                   = azurerm_resource_group.function_rg.location
  resource_group_name        = azurerm_resource_group.function_rg.name
  storage_account_name       = azurerm_storage_account.function_storage.name
  app_service_plan_id        = azurerm_app_service_plan.function_plan.id
  version                    = "~3"
  os_type                    = "linux"
  runtime_stack              = var.runtime_stack

  app_settings = {
    "AzureWebJobsStorage" = azurerm_storage_account.function_storage.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME" = var.functions_worker_runtime
  }
}