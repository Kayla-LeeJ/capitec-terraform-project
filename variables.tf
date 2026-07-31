variable "surname" {
  type        = string
  description = "Surname used in resource naming and tags"
  default     = "jansma"
}

variable "initials" {
  type        = string
  description = "Initials used in resource naming and tags"
  default     = "kl"
}

variable "prefix" {
  type        = string
  description = "Prefix used for all resource names"
  default     = "jansmakl"
}

variable "resource" {
  type        = string
  description = "Resource type label used in S3 bucket naming"
  default     = "s3"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  validation {
    condition     = contains(["dev", "int", "prod"], var.environment)
    error_message = "environment must be one of: dev, int, prod."
  }
}

variable "capacity_type" {
  type        = string
  description = "Type of capacity to launch for EKS node group (ON_DEMAND or SPOT)"
  default     = "ON_DEMAND"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be either ON_DEMAND or SPOT."
  }
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources into"
  default     = "af-south-1"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to deploy subnets into"
  default     = "vpc-04afeafc288c397af"
}

variable "rt_id" {
  type        = string
  description = "ID of the route table to associate with subnets"
  default     = "rtb-023fc1846d75af176"
}
