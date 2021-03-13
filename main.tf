
variable "zone_id" {
  description = "Zone id for record"
}

variable "name" {
  type        = string
  description = "The name of the record."
}

variable "value" {
  type        = string
  description = "The (string) value of the record. Either this or data must be specified."
}

variable "type" {
  type        = string
  description = "The type of the record."
  default     = "A"

}

variable "ttl" {
  type        = number
  description = "The TTL of the record (default: '300')"
  default     = 300
}

variable "proxied" {
  type        = bool
  description = "Whether the record gets Cloudflare's origin protection; defaults to false."
  default     = false
}

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


output "id" {
  description = "The record ID"
  value       = cloudflare_record.record.id
}

output "hostname" {
  description = "The FQDN of the record"
  value       = cloudflare_record.record.hostname
}

output "fqdn" {
  description = "The FQDN of the record"
  value       = cloudflare_record.record.hostname
}

output "proxiable" {
  description = "Shows whether this record can be proxied, must be true if setting proxied=true"
  value       = cloudflare_record.record.proxiable
}

output "created_on" {
  description = "The RFC3339 timestamp of when the record was created"
  value       = cloudflare_record.record.created_on
}

output "modified_on" {
  description = "The RFC3339 timestamp of when the record was last modified"
  value       = cloudflare_record.record.modified_on
}

output "metadata" {
  description = "A key-value map of string metadata Cloudflare associates with the record"
  value       = cloudflare_record.record.metadata
}
