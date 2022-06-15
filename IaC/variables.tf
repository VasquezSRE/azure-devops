variable "storage_account_name" {
  description = "The name of the storage account used by the function app"
  type        = string
  default     = ""
}

variable "app_service_plan_name" {
  description = "The name of the app service plan used by the function app"
  type        = string
  default     = ""
}

variable "function_app_name" {
  description = "The name of the function app"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the new resource group the resources will be deployed in"
  type        = string
  default     = ""
}

variable "resource_group_location" {
  description = "Location for resource group deployment "
  type        = string
  default     = ""
}