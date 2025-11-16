variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location for the resources"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "function_app_name" {
  description = "The name of the Function App"
  type        = string
}

variable "runtime_stack" {
  description = "The runtime stack for the Function App"
  type        = string
}

variable "functions_worker_runtime" {
  description = "The worker runtime for Azure Functions"
  type        = string
}
