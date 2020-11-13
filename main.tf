terraform {
  required_version = ">=0.12.23"
}

provider "azurerm" {
  version = "~> 2.35.0"
  features {}
}

module "keyvault" {
  source = "github.com/avinor/terraform-azurerm-key-vault"
  //  source  = "avinor/key-vault/azurerm"
  //  version = "1.0.0"

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  access_policies = [
    {
      object_id               = azurerm_user_assigned_identity.identity.principal_id
      secret_permissions      = ["get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = ["get"]
    },
  ]

  tags = var.tags
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
}
