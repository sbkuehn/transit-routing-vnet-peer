variable "resource_group_name" {
  description = "Resource group containing the VNets"
  type        = string
}

variable "vnet_west_name" {
  description = "Name of the West US VNet"
  type        = string
}

variable "vnet_east_name" {
  description = "Name of the East US VNet"
  type        = string
}
