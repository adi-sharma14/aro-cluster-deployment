# Sensistive variables are intentionally marked as EMPTY
# Either add these sensitive variables in TFCB workspace and mark as sensitive, OR update the file locally before running the terraform commands
# DO NOT commit this file with sensisitve values to VCS. 

subscription            = ""
tf_clientId             = ""
tf_tenantId             = ""
tf_client_secret        = ""
aro_aadClientId         = ""
aro_aadObjectId         = ""
aro_aadTenantId         = ""
aro_pull_secret         = ""
aro_aadClientSecret     = ""
aro_resource_group_name = "aro-rg"
aro_location            = "australiaeast"
aro_name                = "arodemo"
vnet_name               = "aro-vnet"
aro_master_subnet       = "10.0.0.0/23"
aro_worker_subnet       = "10.0.2.0/23"
aro_vnet_iprange        = "10.0.0.0/22"
aro_master_size         = "Standard_D8s_v3"
aro_worker_size         = "Standard_D4s_v3"
aro_worker_count        = 3
aro_api_visibility      = "Public"
aro_ingress_visibility  = "Public"
aro_domain              = "demo"