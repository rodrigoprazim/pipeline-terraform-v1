terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.104.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg1-rodrigoprazim"                            # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "rodrigoprazimterraform"                       # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "remote-state"                                 # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "azure-pipeline-github/prod.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "aws" {
  region = "us-west-1"

  default_tags {
    tags = {
      owner      = "rodrigoprazim"
      managed-by = "terraform-dev"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "rodrigoprazim-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-west-1"
  }
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg1-rodrigoprazim"
    storage_account_name = "rodrigoprazimterraform"
    container_name       = "remote-state"
    key                  = "azure-vnet/prod.terraform.tfstate"
  }
}
