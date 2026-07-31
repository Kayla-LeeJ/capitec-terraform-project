variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to create subnets in"
  default     = ["af-south-1a", "af-south-1b", "af-south-1c"]
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to create subnets in"
}

variable "rt_id" {
  type        = string
  description = "ID of the route table to associate with subnets"
}

variable "surname" {
  type        = string
  description = "Surname used in tags"
  default     = "jansma"
}

variable "initials" {
  type        = string
  description = "Initials used in tags"
  default     = "kl"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, int, prod)"
}

variable "prefix" {
  type        = string
  description = "Prefix used for all resource names"
  default     = "jansmakl"
}

variable "lookup_key" {
  type        = string
  description = "Key to look up subnet CIDR allocation in the subnet_allocation map"
  default     = "kayla_lee_jansma"
}
