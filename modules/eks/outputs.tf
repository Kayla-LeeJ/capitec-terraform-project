output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eks-cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint URL of the EKS cluster API server"
  value       = aws_eks_cluster.eks-cluster.endpoint
}

output "cluster_security_group_id" {
  description = "ID of the security group attached to the EKS cluster"
  value       = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
}

output "node_group_arn" {
  description = "ARN of the EKS managed node group"
  value       = aws_eks_node_group.eks-ng.arn
}

output "cluster_certificate_authority" {
  description = "Base64-encoded certificate authority data for the EKS cluster"
  value       = aws_eks_cluster.eks-cluster.certificate_authority[0].data
  sensitive   = true
}
