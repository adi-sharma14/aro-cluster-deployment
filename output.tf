# The Terraform outputs for cluster configs

output "aro-cluster" {
  value = azurerm_template_deployment.azure-arocluster
}