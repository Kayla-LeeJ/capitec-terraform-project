output "subnet_ids" {
  description = "List of subnet IDs created by the subnet module"
  value       = module.kayla-subnet.subnet_ids
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.kayla-eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint URL of the EKS cluster API server"
  value       = module.kayla-eks.cluster_endpoint
}

output "backend_bucket_name" {
  description = "Name of the S3 state backend bucket"
  value       = module.kayla-s3.bucket_name
}
