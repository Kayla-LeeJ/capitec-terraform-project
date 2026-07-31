# Module: s3

Manages the S3 bucket used as a Terraform remote state backend. The bucket is typically pre-created and imported. Versioning is enabled to support state file recovery.

## Usage

```hcl
module "s3" {
  source      = "./modules/s3"
  prefix      = "jansmakl"
  environment = "dev"
  initials    = "kl"
  surname     = "jansma"
}
```

## Importing a pre-existing bucket

```bash
terraform import module.kayla-s3.aws_s3_bucket.jansmakl-s3-backend jansmakl-s3-backend
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| prefix | Prefix for bucket naming | `string` | `"jansmakl"` | no |
| environment | Deployment environment | `string` | — | yes |
| initials | Initials used in tags | `string` | `"kl"` | no |
| surname | Surname used in tags | `string` | `"jansma"` | no |
| resource | Resource label for bucket naming | `string` | `"s3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | Name of the S3 backend bucket |
| bucket_arn | ARN of the S3 backend bucket |

## Requirements

| Name | Version |
|------|---------|
| terraform | `~> 1.15` |
| aws provider | `~> 6.0` |
