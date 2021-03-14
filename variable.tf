variable "zone_id" {
  type        = string
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
