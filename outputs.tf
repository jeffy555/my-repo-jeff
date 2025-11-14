output "resource_group_name" {
  value = azurerm_resource_group.my_resource_group.name
}

output "acr_name" {
  value = azurerm_container_registry.my_acr.name
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.my_container_app_env.id
}

output "container_app_id" {
  value = azurerm_container_app.my_container_app.id
}
