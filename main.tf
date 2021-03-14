resource "cloudflare_record" "record" {
  zone_id = var.zone_id
  name    = var.name
  value   = var.value
  type    = var.type
  ttl     = var.ttl
  proxied = var.proxied

  #   TODO
  #   data = object
  #   priority = opicional
}
