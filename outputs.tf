output "wg_dns_record" {
  value = cloudflare_dns_record.wg_dns.name
}

output "wg_ip" {
  value = chomp(data.http.my_ip.response_body)
}
