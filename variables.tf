variable "name" {
  description = "Name of the Keyvault"
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "The Azure Region in which to create resources."
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are `standard` and `premium`."
  default     = "standard"
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to `false`."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to `false`."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to `false`."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted."
  type        = number
  default     = 7
}

variable "access_policies" {
  description = "Map of access policies for an object_id (user, service principal, security group) to backend."
  type        = list(object({ object_id = string, certificate_permissions = list(string), key_permissions = list(string), secret_permissions = list(string), storage_permissions = list(string) }))
  default     = []
}

variable "network_acls" {
  description = "Network rules to apply to key vault."
  type        = object({ bypass = string, default_action = string, ip_rules = list(string), virtual_network_subnet_ids = list(string) })
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
  default     = null
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