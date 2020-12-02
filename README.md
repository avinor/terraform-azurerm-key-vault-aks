# Azure AKS Keyvault Integration

Deployes a keyvault integrated with AKS bases on Azure identity and 
[Azure Key Vault Provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure)

This module uses Key vault module as base module. There is an additional creation of user assigned identities in this module to support integration with AKS.

See [Key Vault module](https://github.com/avinor/terraform-azurerm-key-vault) for more details

## Usage

A simple example that deploys a key vault using access_policies

This example is using [tau](https://github.com/avinor/tau) for deployment.
```
module {
  source = "github.com/avinor/terraform-azurerm-key-vault-aks"
}

inputs {
  name                = "my-keyvault-aks"
  resource_group_name = "my-keyvault-aks-rg"
  location            = "westeurope"

  aks_principal_id    = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

  access_policies = [
    {
      object_id               = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      secret_permissions      = ["get", "list", "set", "delete"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
  ]
}
```