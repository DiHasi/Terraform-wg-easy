variable "domain" {
  type        = string
  description = "DNS name for WireGuard server"
}

variable "zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

variable "cloudflare_api_token" {
  type      = string
  description = "Cloudflare API token"
  sensitive = true
}

variable "wg_internal_port" {
  type    = number
  default = 51821
}

variable "caddy_api_endpoint" {
  type    = string
  default = "unix:///var/run/caddy/admin.sock"
}
