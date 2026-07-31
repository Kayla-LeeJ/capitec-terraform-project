variable "availability_zones" {
  type    = list(string)
  default = ["af-south-1a", "af-south-1b", "af-south-1c"]
}

variable "resource" {
  type    = string
  default = "eks"
}

variable "vpc_id" {
  type    = string
  default = "vpc-04afeafc288c397af"
}

variable "rt_id" {
  type    = string
  default = "rtb-023fc1846d75af176"
}

variable "eks_version" {
  type    = string
  default = "1.35"
}

variable "surname" {
  type = string
  default = "jansma"
}

variable "initials" {
  type = string
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

variable "instance_types" {
  type    = list(string)
  default = ["t3.micro"]
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 3
}

variable "node_desired_size" {
  type    = number
  default = 2
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


# aws eks update-kubeconfig --region af-south-1 --name jansmakl-eks-dev