# The Terraform outputs for cluster configs

output "aro-cluster" {
  value = nonsensitive(azurerm_template_deployment.azure-arocluster)
}