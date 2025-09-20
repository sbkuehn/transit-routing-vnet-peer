# Author: Shannon Eldridge-Kuehn
# Date: 2025-09-20
# Description: Terraform template to create VNet peering with transit enabled.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features { }
}

data "azurerm_virtual_network" "vnet_west" {
  name                = var.vnet_west_name
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet_east" {
  name                = var.vnet_east_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network_peering" "west_to_east" {
  name                      = "${var.vnet_west_name}To${var.vnet_east_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.vnet_west.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet_east.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

resource "azurerm_virtual_network_peering" "east_to_west" {
  name                      = "${var.vnet_east_name}To${var.vnet_west_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.vnet_east.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet_west.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = true
}
