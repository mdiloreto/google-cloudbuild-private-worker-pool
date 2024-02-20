variable "source_tags" {
  description = "Source Tag list"
  type = list(string)
}

variable "ports" {
  default = "ports"
  type = list(number)
}

variable "source_ranges" {
  description = "Source ip ranges for the rule"
  type = list(number)
}

variable "destination_ranges" {
  description = "Destination ip ranges for the rule"
  type = list(number)
}

variable "rule_name" {
  type = string
  description = "Name of the firewall rule"
}

variable "protocol" {
  type = string  
  description = "Protocol for the rule"
}

variable "network_name" {
  description = "ID of the VPC Network where the rule will be created"
}