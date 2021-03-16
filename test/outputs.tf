output "zone_example_id" {
  value = data.cloudflare_zones.example.id
}

output "record_simple_a_id" {
  value = module.cloudflare_record_simple_a.id
}

output "record_simple_a_hostname" {
  value = module.cloudflare_record_simple_a.hostname
}

output "record_simple_a_fqdn" {
  value = module.cloudflare_record_simple_a.fqdn
}

output "record_simple_a_proxiable" {
  value = module.cloudflare_record_simple_a.proxiable
}

output "record_simple_a_created_on" {
  value = module.cloudflare_record_simple_a.created_on
}

output "record_simple_a_modified_on" {
  value = module.cloudflare_record_simple_a.modified_on
}

output "record_simple_a_metadata" {
  value = module.cloudflare_record_simple_a.metadata
}
