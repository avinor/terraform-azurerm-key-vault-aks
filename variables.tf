variable "name" {
  description = "Name of the Keyvault"
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "The Azure Region in which to create resources."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "aks_principal_id" {
  description = "AKS principal ID for the existing AKS cluster "
  type        = string
}