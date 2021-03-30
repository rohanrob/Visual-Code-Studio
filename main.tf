# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

# Configure the Microsft Aure Provider
provider "azurerm" {
  features {}
}

# Create resource group
resource "azurerm_resource_group" "myrg" {
  name     = "my-res-group"
  location = "east us"
}