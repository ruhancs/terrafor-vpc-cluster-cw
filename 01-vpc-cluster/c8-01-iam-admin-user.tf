# Resource: AWS IAM User - Admin User (Has Full AWS Access)
//criar usuario admin
resource "aws_iam_user" "admin_user" {
  name = "${local.name}-eksadmin1"  
  path = "/"
  force_destroy = true # deletar usuario ao destruir o terraform
  tags = local.common_tags
}

# Resource: Admin Access Policy - Attach it to admin user
//criar politica AdministratorAccess e inserir em admin_user
resource "aws_iam_user_policy_attachment" "admin_user" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" #politica de acesso total na aws, menos no eks caso o usuario nao estiver no configmap
}