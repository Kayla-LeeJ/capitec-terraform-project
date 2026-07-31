variable "surname" {
  type = string
  default = "jansma"
}

variable "initials" {
  type = string
  default = "kl"
}

variable "resource" {
  type = string
  default = "s3"
}

variable "environment" {
  type = string
}

variable "capacity_type" {
  type        = string
  description = "Type of capacity to launch (ON_DEMAND or SPOT)"
  default     = "SPOT"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be either ON_DEMAND or SPOT."
  }
}