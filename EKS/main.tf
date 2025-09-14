data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Busca todas as subnets na VPC
data "aws_subnets" "available" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

# Obtém detalhes das subnets
data "aws_subnet" "details" {
  for_each = toset(data.aws_subnets.available.ids)
  id       = each.value
}

locals {
  # Agrupa subnets por zona de disponibilidade
  subnets_by_az = { for id, subnet in data.aws_subnet.details : subnet.availability_zone => id... }
  
  # Seleciona uma subnet de cada zona de disponibilidade até obter 2 subnets
  selected_subnet_ids = slice(distinct(flatten([
    for az, ids in local.subnets_by_az : [ids[0]]
  ])), 0, 2)
}

resource "aws_eks_cluster" "eks" {
  name     = "eks-cluster"
  role_arn = var.iam_role_arn

  vpc_config {
    subnet_ids = local.selected_subnet_ids
  }

  depends_on = [] # Nenhuma dependência de IAM
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-nodes"
  node_role_arn   = var.iam_role_arn

  subnet_ids = local.selected_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [aws_eks_cluster.eks]
}
