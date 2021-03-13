terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.19.1"
    }
  }
}

variable "cloudflare_zone_name" {
  description = "Name for existent zone for test"
}

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

output "zone_example_id" {
  value = data.cloudflare_zones.example.id
}

output "zone_example" {
  value = data.cloudflare_zones.example
}
