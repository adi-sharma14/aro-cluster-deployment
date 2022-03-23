variable "subscription" {}

variable "tf_clientId" {
  description = "The Client ID used for terarform Service Principal"
}

variable "tf_tenantId" {
  description = "The Application ID used for terarform Service Principal"
}

variable "tf_client_secret" {
  description = "Client secret used for terarform Service Principal to authenticate with Azure"
}

variable "aro_resource_group_name" {
  description = "Name of resource group to deploy ARO resources in."
}

variable "aro_location" {
  description = "The ACR location where all resources should be created"
}

variable "vnet_name" {
  description = "The name of Virtual network"
}

variable "aro_master_subnet" {
  description = "ARO Master Subnet CIDR"
}

variable "aro_worker_subnet" {
  description = "ARO Worker Subnet CIDR"
}

variable "aro_name" {
  description = "The Azure Red Hat OpenShift (ARO) name"
}

variable "aro_vnet_iprange" {
  description = "The IP Range assigned to the ARO VNET"
}

variable "aro_aadClientSecret" {
  description = "The Application secret used by the Azure Red Hat OpenShift"
}

variable "aro_aadClientId" {
  description = "The Application ID used by the Azure Red Hat OpenShift"
}

variable "aro_aadObjectId" {
  description = "The Object ID used by the Azure Red Hat OpenShift Service Principal"
}

variable "aro_aadTenantId" {
  description = "The Object ID used by the Azure Red Hat OpenShift Service Principal"
}

variable "aro_pull_secret" {
  description = "Pull Secret for RedHat Cluster Manager Portal"
}

variable "aro_master_size" {
  description = "Size of VM for master node in ARO"
}

variable "aro_worker_size" {
  description = "Size of VM for worker node in ARO"
}

variable "aro_worker_count" {
  description = "Number of workers in the ARO cluster"
}

variable "aro_api_visibility" {
  description = "Visibility level for API Server in ARO (Public / Private)"
}

variable "aro_ingress_visibility" {
  description = "Visibility level for Ingress in ARO (Public / Private)"
}

variable "aro_domain" {
  description = "Domain prefix for ARO cluster"
}