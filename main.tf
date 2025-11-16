resource "azurerm_resource_group" "test_rg" {
  name     = "test-rg-commit"
  location = "East US"
}

resource "azurerm_storage_account" "test_sa" {
  name                     = "teststoragecommit001"
  resource_group_name      = azurerm_resource_group.test_rg.name
  location                 = azurerm_resource_group.test_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_container_app_environment" "my_container_app_env" {
  name                = "my-container-app-env"
  resource_group_name = azurerm_resource_group.test_rg.name
  location            = azurerm_resource_group.test_rg.location
  app_logs_configuration {
    log_analytics {
      workspace_id = azurerm_log_analytics_workspace.my_workspace.id
      workspace_key = azurerm_log_analytics_workspace.my_workspace.primary_shared_access_key
    }
  }
}

resource "azurerm_app_service_plan" "my_app_service_plan" {
  name                = "my-app-service-plan"
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  sku {
    tier     = "PremiumV2"
    size     = "P1v2"
    capacity = 1
  }
  kind = "Linux"
}

resource "azurerm_app_service" "my_app_service" {
  name                = "my-linux-app-service"
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  app_service_plan_id = azurerm_app_service_plan.my_app_service_plan.id
  kind               = "Linux"
  site_config {
    linux_fx_version = "DOCKER|mydockerhub/myapp:latest"
  }
}