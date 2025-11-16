variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "container_app_env_name" {
  description = "Name of the Container App Environment"
  type        = string
  default     = "my-container-app-env"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "my-app-service-plan"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "my-linux-app-service"
}

variable "app_service_plan_tier" {
  description = "Pricing tier for the App Service Plan"
  type        = string
  default     = "PremiumV2"
}

variable "app_service_plan_size" {
  description = "Size for the App Service Plan"
  type        = string
  default     = "P1v2"
}