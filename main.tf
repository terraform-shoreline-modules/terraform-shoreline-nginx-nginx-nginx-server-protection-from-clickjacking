terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "nginx_server_protection_from_clickjacking" {
  source    = "./modules/nginx_server_protection_from_clickjacking"

  providers = {
    shoreline = shoreline
  }
}