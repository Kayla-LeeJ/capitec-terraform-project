variable "availability_zones" {
  type    = list(string)
  default = ["af-south-1a", "af-south-1b", "af-south-1c"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-04afeafc288c397af"
}

variable "rt_id" {
  type    = string
  default = "rtb-023fc1846d75af176"
}

variable "surname" {
  type    = string
  default = "jansma"
}

variable "initials" {
  type    = string
  default = "kl"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, int, prod)"
}

variable "prefix" {
  type    = string
  default = "jansmakl"
}

variable "lookup_key" {
  type        = string
  description = "Key to lookup in subnet_allocation map (e.g., 'kayla_lee_jansma')"
  default     = "kayla_lee_jansma"
}
