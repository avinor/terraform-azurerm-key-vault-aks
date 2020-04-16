output "identity_id" {
  description = "The ID of the user assigned identity "
  value       = azurerm_user_assigned_identity.identity.id
}

output "identity_client_id" {
  description = "The ClientID of the created identity"
  value       = azurerm_user_assigned_identity.identity.client_id
}

output "identity_principal_id" {
  description = "The PrincipalID of the created identity "
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "keyvault_id" {
  description = "The ID of the key vault created"
  value       = module.keyvault.id
}

output "keyvault_name" {
  description = "Name of key vault created."
  value       = module.keyvault.name
}

output "keyvault_vault_uri" {
  description = "The URI of the key vault, used for performing operations on keys and secrets."
  value       = module.keyvault.vault_uri
}