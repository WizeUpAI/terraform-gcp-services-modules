// Input variables for this service
variable "dns_records" {
  description = "List of DNS records to create"
  type = list(object({
    name    = string     # e.g. "www.example.com."
    type    = string     # e.g. "A", "CNAME", "TXT"
    ttl     = number
    rrdatas = list(string)
    managed_zone = string # DNS managed zone name
  }))
}