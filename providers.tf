terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
      caddy = {
      source = "conradludgate/caddy"
      version = "0.2.8"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "caddy" {
  host = var.caddy_api_endpoint
}
