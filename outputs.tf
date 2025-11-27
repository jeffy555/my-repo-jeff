output "resource_group_name" {
  value = azurerm_resource_group.test_rg.name
}

output "acr_name" {
  value = azurerm_storage_account.test_sa.name
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.my_container_app_env.id
}

output "container_app_id" {
  value = azurerm_app_service.my_app_service.id
}

output "app_service_plan_id" {
  value = azurerm_app_service_plan.my_app_service_plan.id
}

output "logic_app_workflow_id" {
  value = azurerm_logic_app_workflow.http_triggered_logic_app.id
}