locals {
  default_tags = {
    Owner       = "${var.initials} ${var.surname}"
    Environment = var.environment
  }
} 