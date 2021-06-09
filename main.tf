terraform {
  required_version = ">=0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.53.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  msi_access_policy = [
    {
      object_id               = azurerm_user_assigned_identity.identity.principal_id
      secret_permissions      = ["get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = ["get"]
    },
  ]

  all_access_policies = concat(local.msi_access_policy, var.access_policies)
}

module "keyvault" {
  source  = "avinor/key-vault/azurerm"
  version = "3.0.0"

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                        = var.sku_name
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_retention_days      = var.soft_delete_retention_days
  access_policies                 = local.all_access_policies
  network_acls                    = var.network_acls
  diagnostics                     = var.diagnostics
  tags                            = var.tags
}

resource "azurerm_user_assigned_identity" "identity" {
  name                = "${var.name}-msi"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags

  depends_on = [module.keyvault.name]
}

resource "azurerm_role_assignment" "reader" {
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
  scope                = module.keyvault.id
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "msi" {
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
  scope                = module.keyvault.id
  role_definition_name = "Managed Identity Operator"
}

resource "azurerm_role_assignment" "aks" {
  principal_id         = var.aks_principal_id
  scope                = azurerm_user_assigned_identity.identity.id
  role_definition_name = "Managed Identity Operator"

  lifecycle {
    ignore_changes = [scope]
  }
}
