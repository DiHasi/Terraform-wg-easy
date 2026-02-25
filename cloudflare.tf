resource "cloudflare_dns_record" "wg_dns" {
  zone_id = var.zone_id
  name    = var.domain
  content = chomp(data.http.my_ip.response_body)
  type    = "A"
  ttl     = 1
  proxied = false
  comment = "Created by Terraform"
}
