#--------------------------------#
# Module: eks
#--------------------------------# 
#Resource: aws_subnet
resource "aws_subnet" "az" {
  for_each                = { for i, az in var.availability_zones : az => i }
  vpc_id                  = var.vpc_id
  cidr_block              = local.subnet_allocation.kayla_lee_jansma.subnets[each.value]
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(local.default_tags, {
    Name = "${var.prefix}-az${each.value + 1}-subnet-${var.environment}"
  })
  lifecycle {
    ignore_changes = [tags]
  }
}

#Resource: aws_route_table_association
resource "aws_route_table_association" "rt-association" {
  for_each       = aws_subnet.az
  subnet_id      = each.value.id
  route_table_id = var.rt_id
}

#Resource: aws_eks_cluster
resource "aws_eks_cluster" "eks-cluster" {
  name = "${var.prefix}-${var.resource}-${var.environment}"

  access_config {
    authentication_mode = "API"
    #bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids = values(aws_subnet.az)[*].id
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling. 
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
  tags = merge(local.default_tags, {
    Name = "${var.prefix}-${var.resource}-${var.environment}"
  })
}

#Resource: aws_iam_role
resource "aws_iam_role" "eks-cluster-role" {
  name = "${var.prefix}-${var.resource}-cluster-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(local.default_tags, {
    Name = "${var.prefix}-${var.resource}-cluster-role-${var.environment}"
  })
}

#Resource: aws_iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

# authentication_mode = "API" means Kubernetes RBAC access is governed
# entirely by EKS access entries, not IAM policies or aws-auth. Without
# this, the IAM principal that creates/manages the cluster has no way
# to authenticate to the Kubernetes API.
data "aws_caller_identity" "current" {}

#Resource: aws_eks_access_entry
resource "aws_eks_access_entry" "eks-access-entry" {
  cluster_name  = aws_eks_cluster.eks-cluster.name
  principal_arn = data.aws_caller_identity.current.arn
  type          = "STANDARD"
  tags = merge(local.default_tags, {
    Name = "${var.prefix}-${var.resource}-access-entry-${var.environment}"
  })
}
#Resource: aws_eks_access_policy_association
resource "aws_eks_access_policy_association" "admin" {
  cluster_name  = aws_eks_cluster.eks-cluster.name
  principal_arn = aws_eks_access_entry.eks-access-entry.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
#Resource: aws_iam_role
resource "aws_iam_role" "node-iam-role" {
  name = "${var.prefix}-${var.resource}-node-iam-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(local.default_tags, {
    Name = "${var.prefix}-${var.resource}-node-iam-role-${var.environment}"
  })
}
#Resource: aws_iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "node-policy-attachments" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ])
  policy_arn = each.value
  role       = aws_iam_role.node-iam-role.name
}

#Resource: aws_security_group_rule
resource "aws_security_group_rule" "nodeport-ingress-sg" {
  type              = "ingress"
  from_port         = 30007
  to_port           = 30007
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_eks_cluster.eks-cluster.vpc_config[0].cluster_security_group_id
  description       = "Allow inbound access to nginx NodePort service"
}
#Resource: aws_eks_node_group
resource "aws_eks_node_group" "eks-ng" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.prefix}-${var.resource}-ng-${var.environment}"
  node_role_arn   = aws_iam_role.node-iam-role.arn
  subnet_ids      = values(aws_subnet.az)[*].id

  capacity_type  = var.capacity_type
  instance_types = var.instance_types

  scaling_config {
    min_size     = var.node_min_size
    max_size     = var.node_max_size
    desired_size = var.node_desired_size
  }

  update_config {
    max_unavailable = 1
  }

  tags = merge(local.default_tags, {
    Name = "${var.prefix}-${var.resource}-ng-${var.environment}"
  })

  # Ensure IAM permissions are created before and deleted after the
  # node group, otherwise EKS cannot properly bootstrap/tear down nodes.
  depends_on = [
    aws_iam_role_policy_attachment.node-policy-attachments,
  ]
}