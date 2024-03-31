# Description

For now this repo only contains management scripts and Terraform files to deal with Azure cloud; in case alternative cloud providers are required, 
more folders should be created. 

# Management scripts

The management scripts should be idempotent. At least in the case of Azure cloud, they create a few resources that are not supposed to be managed. Those resources are 
a resource group and a key vault. KV is needed to hold credentials for a service provider under which Terraform operates. 
Other resources should be managed purely by Terraform.

1. InitEnv.ps1 - initializes the aforementioned resources if they don't exist, then adds env variables for the current powershell session, so that
   Terraform uses correct credentials
2. PrepareFunction.ps1 - publishes function with a name passed in as a parameter and compresses it to a zip archive, so that it can be deployed by terraform

# Running terraform

The procedure is simple:

1. cd ./scripts
2. Run InitEnv.ps1 with the word "local" as the parameter
3. Run Terraform commands

# Issues

As of 31.03.2024, every time when I was trying to provision resources outside Poland Central location, I got a ton of errors - dependent resources not available.
That's why those blocks were added for the most problematic resources:

```
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
    read   = "10m"
  }
```
