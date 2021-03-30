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

# Create a subnet within the vnet
resource "azurerm_virtual_network" "mysubnet" {
  name                = "rohan-subnet"
  resource_group_name = "azurerm_resource_group.myrg.name"
  virtual_network_name= "azurerm_resource_group.myvnet.location"
  address_space       = ["10.0.0.0/24"]
}

# Create a network interface for VM
resource "azurerm_network_interface" "mynic" {
  name                = "rohan-nic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mynic.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Virtual Machine in Azure

resource "azurerm_linux_virtual_machine" "myVM" {
  name                = "myVM01"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_A1_v2"
  admin_username      = "student"
  network_interface_ids = [
    azurerm_network_interface.mynic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}