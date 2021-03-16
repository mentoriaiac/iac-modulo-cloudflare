data "cloudflare_zones" "example" {
  filter {
    name = var.cloudflare_zone_name
  }
}

module "cloudflare_record_simple_a" {
  source  = "../"
  zone_id = data.cloudflare_zones.example.zones[0].id
  name    = "simple-a"
  value   = "192.168.1.1"
}

module "cloudflare_record_simple_declared_a" {
  source  = "../"
  zone_id = data.cloudflare_zones.example.zones[0].id
  name    = "simple-declared-a"
  value   = "192.168.1.1"
  type    = "A"
  ttl     = "3600"
}

module "cloudflare_record_simple_declared_a_2" {
  source  = "../"
  zone_id = data.cloudflare_zones.example.zones[0].id
  name    = "simple-declared-a"
  value   = "192.168.1.2"
  type    = "A"
  ttl     = "3600"
}

module "cloudflare_record_simple_declared_a_3" {
  source   = "../"
  zone_id  = data.cloudflare_zones.example.zones[0].id
  name     = "simple-declared-a"
  value    = "192.168.1.3"
  type     = "A"
  ttl      = "3600"
  priority = 1
}

module "cloudflare_record_simple_cname" {
  source  = "../"
  zone_id = data.cloudflare_zones.example.zones[0].id
  name    = "simple-cname"
  value   = "simple-declared-a.com"
  type    = "CNAME"
}

module "cloudflare_record_simple_cname_proxied" {
  source  = "../"
  zone_id = data.cloudflare_zones.example.zones[0].id
  name    = "simple-cname-proxied"
  value   = "simple-declared-a.com"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

module "cloudflare_record_srv" {
  source  = "../"
  zone_id = data.cloudflare_zones.example.zones[0].id
  name    = "_sip._tls"
  type    = "SRV"
  data = {
    service  = "_sip"
    proto    = "_tls"
    name     = "terraform-srv"
    priority = 0
    weight   = 0
    port     = 443
    target   = "example.com"
  }
}
