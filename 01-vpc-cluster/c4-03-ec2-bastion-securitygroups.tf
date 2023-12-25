# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  #version = "4.5.0"  
  version = "4.17.2"

  name = "${local.name}-public-bastion-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id // id da vpc criada em c3-02-vpc-module.tf
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"] //permicao para entrada via internet, permicao para todos
  # Egress Rule - all-all open
  egress_rules = ["all-all"] // permicao de saida para toda internet
  tags = local.common_tags
}