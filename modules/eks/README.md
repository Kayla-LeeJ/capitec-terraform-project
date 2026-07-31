# Module: eks

Provisions an EKS cluster with a managed node group, IAM roles, and an access entry for the deploying principal.

## Usage

```hcl
module "eks" {
  source        = "./modules/eks"
  prefix        = "jansmakl"
  environment   = "dev"
  initials      = "kl"
  surname       = "jansma"
  capacity_type = "ON_DEMAND"
  subnet_ids    = ["subnet-abc123", "subnet-def456"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| prefix | Prefix for all resource names | `string` | `"jansmakl"` | no |
| environment | Deployment environment | `string` | — | yes |
| initials | Initials used in tags | `string` | `"kl"` | no |
| surname | Surname used in tags | `string` | `"jansma"` | no |
| subnet_ids | Subnet IDs for the cluster and nodes | `list(string)` | — | yes |
| capacity_type | `ON_DEMAND` or `SPOT` | `string` | `"ON_DEMAND"` | no |
| eks_version | Kubernetes version | `string` | `"1.35"` | no |
| instance_types | EC2 instance types for nodes | `list(string)` | `["t3.micro"]` | no |
| node_min_size | Minimum node count | `number` | `1` | no |
| node_max_size | Maximum node count | `number` | `3` | no |
| node_desired_size | Desired node count | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_name | Name of the EKS cluster |
| cluster_endpoint | API server endpoint URL |
| cluster_security_group_id | Cluster security group ID |
| node_group_arn | ARN of the managed node group |
| cluster_certificate_authority | Base64-encoded CA data (sensitive) |

## Requirements

| Name | Version |
|------|---------|
| terraform | `~> 1.15` |
| aws provider | `~> 6.0` |
