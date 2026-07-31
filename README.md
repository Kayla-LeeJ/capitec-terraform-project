![header](https://capsule-render.vercel.app/api?type=waving&color=FF9900&height=120&section=header&text=Capitec%20Terraform%20Project&fontSize=36&fontColor=fff&animation=fadeIn)

[![Terraform](https://img.shields.io/badge/Terraform-~%201.15-844FFF?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-6.0-FF9900?logo=amazonaws&logoColor=white)](https://aws.amazon.com/)
[![Region](https://img.shields.io/badge/Region-af--south--1-informational)](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/)

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&color=FF9900&width=500&lines=Modular+Terraform+on+AWS+af-south-1;EKS+%7C+S3+%7C+VPC+Networking;dev+%E2%86%92+int+%E2%86%92+prod)](https://git.io/typing-svg)

---

## Architecture

```mermaid
graph TB
    A["AWS Provider (af-south-1)"] --> B["Root Module"]

    subgraph Modules[" Modules"]
        B --> SN["Subnet Module"]
        B --> EKS["EKS Module"]
        B --> S3["S3 Module"]
        SN --> SN1["aws_subnet"]
        SN --> SN2["route_table_assoc"]
        EKS --> EKS1["aws_eks_cluster"]
        EKS --> EKS2["aws_eks_node_group"]
        EKS --> EKS3["aws_iam_role"]
        EKS -. depends_on .-> SN
    end

    subgraph Environments[" Environments"]
        C["Per Environment"] --> D["dev"]
        C --> E["int"]
        C --> F["prod"]
        D & E & F --> G["S3 Backend State"]
    end

    style A fill:#FF9900,color:#fff
    style B fill:#232F3E,color:#fff
    style SN fill:#FF9900,color:#fff
    style EKS fill:#FF9900,color:#fff
    style S3 fill:#FF9900,color:#fff
    style SN1 fill:#FFB84D,color:#000
    style SN2 fill:#FFB84D,color:#000
    style EKS1 fill:#FFB84D,color:#000
    style EKS2 fill:#FFB84D,color:#000
    style EKS3 fill:#FFB84D,color:#000
    style G fill:#232F3E,color:#fff
    style Modules fill:#1a1a1a,color:#fff,stroke:#FF9900
    style Environments fill:#1a1a1a,color:#fff,stroke:#666
```

---

## Usage

```bash
# Init (swap env as needed: dev, int, prod)
terraform init -backend-config="./values/dev/dev.tfbackend" -reconfigure

# Plan
terraform plan -var-file="./values/dev/dev.tfvars"

# Apply
terraform apply -var-file="./values/dev/dev.tfvars"

# Destroy
terraform destroy -var-file="./values/dev/dev.tfvars"

# EKS access
aws eks update-kubeconfig --region af-south-1 --name jansmakl-eks-dev
```

---

## CI/CD

| Trigger | Action |
|---------|--------|
| Push to `dev` | Auto-apply dev |
| PR to `int`/`prod` | Plan target env, post diff to PR |
| Merge to `int`/`prod` | Auto-apply (with approval gate) |
| Workflow dispatch | Manual plan/apply/destroy |

---

## Key Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `environment` | — | dev / int / prod |
| `capacity_type` | `ON_DEMAND` | ON_DEMAND or SPOT |
| `initials` | `kl` | Used in resource naming |
| `surname` | `jansma` | Used in resource naming |

Naming convention: `jansmakl-eks-dev`

---

![footer](https://capsule-render.vercel.app/api?type=waving&color=FF9900&height=80&section=footer)
