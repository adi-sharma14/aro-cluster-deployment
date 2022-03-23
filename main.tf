provider "azurerm" {
  subscription_id = var.subscription
  client_id       = var.tf_clientId
  tenant_id       = var.tf_tenantId
  client_secret   = var.tf_client_secret
  #features (Required)
  features {
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
  }
}

resource "azurerm_resource_group" "azure-aro-rg" {
  name     = var.aro_resource_group_name
  location = var.aro_location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.aro_location
  resource_group_name = azurerm_resource_group.azure-aro-rg.name
  address_space       = ["10.0.0.0/22"]

  subnet {
    name           = "master-subnet"
    address_prefix = var.aro_master_subnet
  }

  subnet {
    name           = "worker-subnet"
    address_prefix = var.aro_worker_subnet
  }
}

resource "azurerm_template_deployment" "azure-arocluster" {
  #name (Required) Specifies the name of the template deployment. Changing this forces a new resource to be created.
  name = var.aro_name

  #resource_group_name  (Required) The name of the ResourceGroup in which to create the template deployment
  resource_group_name = azurerm_resource_group.azure-aro-rg.name

  #File: Reads the contents of a file at the given path and returns them as a string
  template_body = file("${path.module}/automated_cluster.json")

  #These key-value pairs are provided as parameters to the ARM template
  parameters = {
    "clusterName" : var.aro_name
    "clusterVnetName" : var.vnet_name
    "domain" : var.aro_domain
    "location" : var.aro_location
    "pullSecret" : var.aro_pull_secret
    "clusterVnetCidr" : var.aro_vnet_iprange
    "aadClientId" : var.aro_aadClientId
    "aadObjectId" : var.aro_aadObjectId
    "rpObjectId" : var.aro_aadTenantId
    "aadClientSecret" : var.aro_aadClientSecret
    "masterSubnetCidr" : var.aro_master_subnet
    "masterVmSize" : var.aro_master_size
    "workerSubnetCidr" : var.aro_worker_subnet
    "workerVmSize" : var.aro_worker_size
    "apiServerVisibility" : var.aro_api_visibility
    "ingressVisibility" : var.aro_ingress_visibility
  }

  #(Required) Specifies the mode that is used to deploy resources.
  #This value could be either Incremental or Complete.
  #Note that you will almost always want this be set to Incremental otherwise the deployment will destroy all Infrastructure not specified within the template, and Terraform will not be aware of this.
  deployment_mode = "Incremental"
}

