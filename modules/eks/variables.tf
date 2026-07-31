variable "resource" {
  type        = string
  description = "Resource type label used in naming"
  default     = "eks"
}

variable "eks_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
  default     = "1.35"
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

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for EKS worker nodes"
  default     = ["t3.micro"]
}

variable "node_min_size" {
  type        = number
  description = "Minimum number of nodes in the EKS node group"
  default     = 1
}

variable "node_max_size" {
  type        = number
  description = "Maximum number of nodes in the EKS node group"
  default     = 3
}

variable "node_desired_size" {
  type        = number
  description = "Desired number of nodes in the EKS node group"
  default     = 2
}

variable "capacity_type" {
  type        = string
  description = "Type of capacity to launch (ON_DEMAND or SPOT)"
  default     = "ON_DEMAND"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be either ON_DEMAND or SPOT."
  }
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the EKS cluster and node group"
}
