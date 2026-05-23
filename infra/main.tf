terraform {
  required_version = ">= 1.0.0"
}

# Um recurso local simples para o Checkov validar sem apontar falhas de segurança
resource "local_file" "exemplo" {
  filename = "infra_status.txt"
  content  = "Ambiente de infraestrutura validado com sucesso no laboratorio DevOps!"
}
