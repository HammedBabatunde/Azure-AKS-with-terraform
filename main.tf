
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "terraformstorage2025"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
  }

  required_version = ">= 0.14"
}

provider "azurerm" {
  # Configuration options
  features {}
}

// Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.rg_name}-rg"
  location = var.location
}



// Create a container registry
resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}acr"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  sku                 = "Standard"
  admin_enabled       = false
}


// Create AKS cluster
resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.eks_name}-aks"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "${var.eks_name}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.aks_service_principal_client_id
    client_secret = var.aks_service_principal_password
  }


  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}
