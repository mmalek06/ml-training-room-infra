# Description

For now this repo only contains management scripts and Terraform files to deal with Azure cloud; in case alternative cloud providers are required, 
more folders should be created. 

# Management scripts

The management scripts should be idempotent. At least in the case of Azure cloud, they create a few resources that are not supposed to be managed. Those resources are 
a resource group and a key vault. KV is needed to hold credentials for a service provider under which Terraform operates. 
Other resources should be managed purely by Terraform. <br />

1. InitRemote.ps1 - initializes the aforementioned resources if they don't exist, then adds env variables for the current powershell session, so that
   Terraform uses correct credentials
2. InitLocal.ps1 - sets up local machine for development

# Running terraform

The procedure is simple:

1. cd ./scripts
2. Run InitEnv.ps1 with the word "local" as the parameter
3. Run Terraform commands (with the -var="pg_password=pwd" option)
