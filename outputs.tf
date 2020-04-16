output "identity_id" {
  description = "The ID of the user assign identity "
  value       = azurerm_user_assigned_identity.identity.id
}

output "identity_client_id" {
  description = ""
  value       = azurerm_user_assigned_identity.identity.client_id
}

output "identity_principal_id" {
  description = ""
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "keyvault_id" {
  description = "The ID of the Key Vault."
  value       = module.keyvault.id
}

output "keyvault_name" {
  description = "Name of key vault created."
  value       = module.keyvault.name
}

output "keyvault_vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = module.keyvault.vault_uri
}