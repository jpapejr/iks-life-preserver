##############################################################################
# Terraform Providers
##############################################################################

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.23.1"
    }
  }
}

##############################################################################

provider "ibm" {
  generation = 2
  ibmcloud_api_key = var.apikey
}