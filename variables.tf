variable "zone_id" {
  type        = string
  description = "Zone id for record."
}

variable "name" {
  type        = string
  description = "The name of the record."
}

variable "value" {
  type        = string
  description = "The (string) value of the record. Either this or data must be specified."
  default     = null
}

variable "type" {
  type        = string
  description = "The type of the record."
  default     = "A"

}

variable "ttl" {
  type        = number
  description = "The TTL of the record (default: '300')."
  default     = 300
}

variable "proxied" {
  type        = bool
  description = "Whether the record gets Cloudflare's origin protection; defaults to false."
  default     = false
}

variable "data" {
  type = object({
    service  = string
    proto    = string
    name     = string
    priority = number
    weight   = number
    port     = number
    target   = string
  })
  description = "Map of attributes that constitute the record value. Primarily used for LOC and SRV record types. Either this or value must be specified."
  default     = null
}

variable "priority" {
  type        = number
  description = "The priority of the record."
  default     = null
}
