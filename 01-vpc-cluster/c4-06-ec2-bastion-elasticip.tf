# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  //dependencias para criar o elastic ip, modulo da maquina ec2 e vpc deve ja estar criados
  depends_on = [module.ec2_public, module.vpc ]
  instance = module.ec2_public.id
  //vpc      = true
  tags = local.common_tags  
}