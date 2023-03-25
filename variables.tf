variable "acr_name" {
  type        = string
  description = "Name for container registry"
}


variable "eks_name" {
  type        = string
  description = "Name for kubernetes cluster"
}

variable "rg_name" {
  type        = string
  description = "Name for resources"
}

variable "location" {
  type        = string
  description = "Azure Location of resources"
}

variable "aks_service_principal_client_id" {
  description = "Service Principal App ID"
}

variable "aks_service_principal_password" {
  description = "Service Principal Password"
}