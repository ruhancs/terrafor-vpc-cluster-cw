# Create a Null Resource and Provisioners
//copiar a key eks-terraform-key.pem, para a maquina ec2 bastion host
resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]// depende da maquina ja estar criada para copiar, para executar
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh" //tipo de conexao
    host     = aws_eip.bastion_eip.public_ip // endereco de ip do elastic ip do bastion host para conexao
    user     = "ec2-user" // usuario da maquina ec2 criada tipo t2.micro
    password = ""
    private_key = file("private-key/eks-terraform-key.pem") // permissao para acessar a maquina
  }  

## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
//file provisioner copia arquivos da maquina local para o recurso na nuvem
//neste caso copia a chave eks-terraform-key.pem para a maquina ec2
  provisioner "file" {
    source      = "private-key/eks-terraform-key.pem"
    destination = "/tmp/eks-terraform-key.pem" // copiar na pasta tmp da vm
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
// permissao 400 para conectar na vm via ssh 
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/eks-terraform-key.pem"
    ]
  }
## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
//pegar o id da vpc criada e salvar na maquina local, na pasta local-exec-output-files, no arquivo creation-time-vpc-id.txt
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }

}