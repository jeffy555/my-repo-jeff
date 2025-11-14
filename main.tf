resource "azurerm_resource_group" "my_resource_group" {
  name     = "my-resource-group"
  location = var.location
}

resource "azurerm_container_registry" "my_acr" {
  name                = "mycontainerregistry"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  sku                 = "Basic"
  admin_enabled       = false  # Admin account disabled for security compliance
}

resource "azurerm_container_app_environment" "my_container_app_env" {
  name                = "my-container-app-env"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  ingress {
    external_enabled = true
    target_port     = 80
  }
}

resource "azurerm_container_app" "my_container_app" {
  name                = "my-container-app"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  container {
    image = "mycontainerregistry.azurecr.io/myapp:latest"
    cpu   = 0.5
    memory = 1.0
  }
  environment_id = azurerm_container_app_environment.my_container_app_env.id
}