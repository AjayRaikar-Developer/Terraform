# Terraform with Azure

## Project Structure

 - **Modules:** This folder contains all Azure resource creational modules like ASE, ASP, AppServices & Resource group ..etc

 - **Environment:** This Folder specifies different environments supported like nonprod & prod. Which again contains subfolders with region names where resources will be created.

- **Region:** UsWest2 & East again contains subfolders
    - **Common:** This will create basic resourcse to setup our infra with foundational resources like: 
        - VNET creation
        - Resource-group creation
        - Storage account creation
        - App Service Environment (ASE) creation
        - App Service Plan (ASP) creation
    - **AppService:** This will create all types of web apps 
    - **Functions:** This will create all types of function apps
    - **YAML:** This file contains the deployment script for Azure DevOps

## Deployment Plan
nonprod-infra.yaml file indepth 

- First we have created 2 stages for deployment

- **Stage 1: Terraform_Planning:** Here we do 
    - `Terraform latest` : Install Terraform
    - `Terraform init` : Install Provider Plugins
    - `Terraform validate` : Compile & Validate our Terraform Code
    - `Terraform plan`: Refresh the state and generate the plan

- **Stage 2: Terraform_Deployment:**
    - `Terraform latest` : Install Terraform
    - `Terraform init` : Install Provider Plugins
    - `Terraform apply` : Here we apply the code as per built plan 

- **Terraform_Deployment is dependent on Terraform_Planning**. So we have kept Terraform_Planning indepent due to which its runs 1st and complies our code and ensures everything is fine.

- Also in **Terraform_Deployment** we have depends on `environment: 'non-prod'` which here it means Azure DevOps has an environment feature where you can add approvers before the Stage 2 starts to process all the jobs under it. 
- So, when Stage 1 all jobs are completed it automatically triggers an email to all approvers who are part of the `environment: 'non-prod'` and waits to get there approval.
- Once an approval is given then Stage 2 starts to run all its job in sequences `(lockBehavior: sequential)` as its important for us to run the common folder 1st as it contains foundational infra resources without which our apps cannot be deployed. 
- So due to the dependency on Common Job we have added `dependsOn: 'US_WEST_COMMON'` in function app & app services job.

# Commands
```terraform:
terraform init  #initializing the provider & also checks the syntax & logic

terraform validate #helps to validate the syntax and logics

terraform plan

terraform plan -out my-webapp-deploy-plan.tfplan  #this copies the execution plan to the file my-webapp-deploy-plan.tfplan 

terraform apply

terraform apply .\my-webapp-deploy-plan.tfplan  #this applies a specific plan to run or execute

terraform output  #this helps to print the output again if needed 

terraform destroy

terraform fmt -check #this command helps to identify formatting needed files

terraform fmt  #this command corrects the formatting needed for the files and saves it

terraform console #starts an interactive console mode to test functions

terraform state list #list all state resource

terraform state show ADDRESS  #show a specific resource

terraform state mv SOURCE DESTINATION #move an item in state

terraform state rm SOURCE DESTINATION #remove an item in state

terraform init -backend-config="access_key=" -reconfigure #reconfigure backend of terraform

terraform init -migrate-state  -backend-config="access_key="  #migrate terraform backend state

#import an existing resource to the state file 
terraform import module.west_app_service_plan.azurerm_service_plan.main[0] /subscriptions/296ee8d5-a7ec-4211-af24-0a454940c919/resourceGroups/n0-azsub-usw2-rg1/providers/Microsoft.Web/serverFarms/n0-azsub-uswest2-asp1


These notion are shown in the terraform plan for resource - 
+ => Add
- => Remove or Delete
~ => Update 
-/+ => Replacement
```