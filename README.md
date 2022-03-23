# aro-cluster-deployment


Below tasks will be required to successfuly demonstrate the migration of Openstack application to ARO cluster.

## 1. Automate the creation of Azure RedHat Openshift (ARO) Cluster

* Cluster is made up of 3 master + 3 worker nodes.
* Cluster is created in `Australia East` region, however it can be deployed in any [supported](https://azure.microsoft.com/en-us/global-infrastructure/services/?products=openshift&regions=all) region.
* Automated using Terraform scripts and ARM template.
* Terraform Cloud is utilized to execute the workflow.

### Pre-Requisites

1. Available Resource Quota in the subscription
    *  Machines from Standard DSv3 SKU : 10
    *  Minimum cores : 40
    ```
    export LOCATION=australiaeast  ## Use eastus or appropriate location
    export CLUSTER=arodemo
    export RESOURCEGROUP=aro-rg
    az vm list-usage -l $LOCATION --query "[?contains(name.value, 'standardDSv3Family')]" -o table
    ```

2.  Register the resource providers. Execute below commands:
    ```
    az account set --subscription <SUBSCRIPTION ID>
    az provider register -n Microsoft.RedHatOpenShift --wait
    az provider register -n Microsoft.Compute --wait
    az provider register -n Microsoft.Storage --wait
    az provider register -n Microsoft.Authorization --wait
    ```

3. Create service principal for terraform to create Azure resources.
    ```
    scope=`az group show --name aro-rg --query id`
    az ad sp create-for-rbac --role Contributor --name 'terraform' --scopes $scope
    ```
    Retrieve the password and store it as  `tf_client_secret` in terraform cloud variables.

4. Create service principal for cluster to interact with Azure.
    ```
    az ad sp create-for-rbac --name 'aro-app-sp' --role Owner --scopes $scope
    ```
    Retrieve the password and store it as  `aro_aadClientSecret` in terraform cloud variables.

5. Update the terraform variables with the Service Principal IDs
    ```
    az ad sp list --filter "displayname eq 'terraform'" --query "[?appDisplayName=='terraform'].{name: appDisplayName, objectId: objectId, tf_tenantId: appOwnerTenantId, tf_clientId: appId}"
    az ad sp list --filter "displayname eq 'aro-app-sp'" --query "[?appDisplayName=='aro-app-sp'].{name: appDisplayName, aro_aadObjectId: objectId, aro_aadTenantId: appOwnerTenantId, aro_aadClientId: appId}"

    ```
    Retrieve the IDs and update in terraform cloud variables

6. Set-up Account on RedHat cluster Manager portal to extract pull secrets.
    * Create account with business email
    * Download the pull secrets and store it under `Variables` within terraform cloud workspace as `aro_pull_secret`


### How to perform the changes
1. Set-up new workspace `arctiq_mission` and SCM [Repo](https://github.com/adi-sharma14/arctiq_mission) path in Terraform cloud free account (business account for production setup)
2. Create sensitive variables in Terraform cloud workspace. Other variables can be referred [HERE](https://github.com/adi-sharma14/arctiq_mission/blob/main/vars_workspace.auto.tfvars).
3. Go to the workspace --> Click  `Actions` --> click `Start new plan`
4. Review the plan carefully and Click `Confirm and Apply`

### How to access the cluster

    * Retrieve username/password for openshift console via below command
    ```
    az aro show --name $CLUSTER --resource-group $RESOURCEGROUP --query "consoleProfile.url" -o tsv
    az aro list-credentials --name $CLUSTER --resource-group $RESOURCEGROUP
    oc login
    ```
    All Done !!!

## 2. Deploy ArgoCD and synchronize cluster configurations

Refer inststructions [HERE]()


## 3. Deploy demo application using S2I build strategy

Refer inststructions [HERE]()


