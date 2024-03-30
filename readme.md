# Description

For now it just contains management scripts and Terraform files to deal with Azure cloud; in case alternative cloud providers are required, more folders should be created. 
The management scripts should be idempotent. At least in the case of Azure cloud, they create a few resources that are not supposed to be managed. Those resources are 
a resource group and a key vault. KV is needed to hold credentials for a service provider under which Terraform operates. Other resources should be managed purely by Terraform.
