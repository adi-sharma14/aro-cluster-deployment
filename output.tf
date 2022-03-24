# The Terraform outputs

output "aro-cluster" {
  value = azurerm_template_deployment.azure-arocluster
}