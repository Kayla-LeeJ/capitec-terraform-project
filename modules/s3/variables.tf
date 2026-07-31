variable "resource" {
  type        = string
  description = "Resource type label used in bucket naming"
  default     = "s3"
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
