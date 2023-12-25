# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.63"
      version = ">= 4.65"      
     }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    //criar bucket e pastas
    bucket = "nome-bucket"
    key    = "pastas-bucket/terraform.tfstate" //caminho de pastas que o arquivo estara salvo
    region = "us-east-1" 
 
    # For State Locking
    //evitar que duas pessoas atualizem a infraestrutura juntas
    //criar tabela com partition key = LockID
    dynamodb_table = "dev-ekscluster"    
  }  
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/