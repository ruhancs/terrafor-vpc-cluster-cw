# Create AWS EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${local.name}-${var.cluster_name}"
  role_arn = aws_iam_role.eks_master_role.arn //arn das politicas de acesso do cluster
  version = var.cluster_version

  vpc_config {
    subnet_ids = module.vpc.public_subnets //ids das subnets publicas, criadas em vpc-output, cluster criado nas subnets publicas
    endpoint_private_access = var.cluster_endpoint_private_access // false
    endpoint_public_access  = var.cluster_endpoint_public_access // true
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs // libera acesso publico geral via endpoint para o eks
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr // endereco kubernets network
  }
  
  # Enable EKS Cluster Control Plane Logging
  //logs do cluster no cloudwatch
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    //dependencias para criar o cluster
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController,
  ]
}