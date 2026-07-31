# Module: subnet

Provisions public subnets across availability zones and associates them with a route table. CIDR blocks are assigned from a pre-defined allocation map keyed by participant name.

## Usage

```hcl
module "subnet" {
  source      = "./modules/subnet"
  prefix      = "jansmakl"
  environment = "dev"
  initials    = "kl"
  surname     = "jansma"
  vpc_id      = "vpc-04afeafc288c397af"
  rt_id       = "rtb-023fc1846d75af176"
  lookup_key  = "kayla_lee_jansma"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| prefix | Prefix for all resource names | `string` | `"jansmakl"` | no |
| environment | Deployment environment | `string` | — | yes |
| initials | Initials used in tags | `string` | `"kl"` | no |
| surname | Surname used in tags | `string` | `"jansma"` | no |
| vpc_id | VPC ID to create subnets in | `string` | — | yes |
| rt_id | Route table ID to associate with subnets | `string` | — | yes |
| lookup_key | Key into the `subnet_allocation` CIDR map | `string` | `"kayla_lee_jansma"` | no |
| availability_zones | AZs to create subnets in | `list(string)` | `["af-south-1a","af-south-1b","af-south-1c"]` | no |

## Outputs

| Name | Description |
|------|-------------|
| subnet_ids | List of created subnet IDs |
| subnet_map | Map of AZ name to subnet object |
| default_tags | Default tags applied to resources |

## Requirements

| Name | Version |
|------|---------|
| terraform | `~> 1.15` |
| aws provider | `~> 6.0` |
