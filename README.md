# Azure AKS Keyvault Integration 

UNDER DEVELOPMENT!

Deployes a keyvault integrated with AKS bases on Azure identity and 
[Azure Key Vault Provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure)

## Usage

A simple example that deploys a keyvault using access_policies

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