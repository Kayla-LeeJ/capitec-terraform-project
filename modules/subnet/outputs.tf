output "subnet_ids" {
  description = "List of subnet IDs"
  value       = values(aws_subnet.az)[*].id
}

output "subnet_map" {
  description = "Map of availability zones to subnet objects"
  value       = aws_subnet.az
}

output "default_tags" {
  description = "Default tags to apply to resources"
  value       = local.default_tags
}
