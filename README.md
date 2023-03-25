## Creating Azure Storagefor Terraform State File

1. Edit the variables in create-terraform-storage
2. Run the script  
`bash create-terraform-storage.sh`

## Create an Active Directory service principal account

1. Run the command below
`az ad sp create-for-rbac --skip-assignment`


## Create AKS and ACR using terraform

Follow the steps below.

1. Create terraform.tfvars file and create values for the variables
2. Run `terraform init`
3. Run `terraform plan`
4. Run `terraform apply --auto-approve `

## Allow AKS to Pull images from ACR
Run this command to allow AKS to pull images from ACR.

1. `az aks get-credentials --resource-group <resource-group-name> --name <aks-name>`
2. ` az aks update -n <aks-name> -g <resource-group> --attach-acr <acr-name>`

## Deploying a demo project
cd into the Docker folder and run the following commands
1. `docker build -t uberapp .`
2. `docker tag uberapp <acr-name>.azurecr.io/uberapp`
3. `docker push <acr-name>.azurecr.io/uberapp`

cd into the kubernetes folder and run the following commands
1. kubectl 
2. `kubectl apply -f uberapp-deployment.yaml`
