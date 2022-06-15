terraform {
    required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.10"
    }
}

required_version = ">= 1.2.2"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "function-rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "function-storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.function-rg.name
  location                 = azurerm_resource_group.function-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "function-plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.function-rg.location
  resource_group_name = azurerm_resource_group.function-rg.name
  os_type             = "Linux"
  sku_name            = "S1"

}

resource "azurerm_linux_function_app" "function-app" {
  name                       = var.function_app_name
  location                   = azurerm_resource_group.function-rg.location
  resource_group_name        = azurerm_resource_group.function-rg.name
  service_plan_id            = azurerm_service_plan.function-plan.id
  storage_account_name       = azurerm_storage_account.function-storage.name
  storage_account_access_key = azurerm_storage_account.function-storage.primary_access_key
  https_only                 = true
  functions_extension_version = "~4"
  site_config {
      always_on  = true
      application_stack {
        node_version = 16
      }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
  }

}

