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

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "myvnet" {
  name                = "rohan-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "azurerm_resource_group.myrg.location"
  resource_group_name = "azurerm_resource_group.myrg.name"
  }