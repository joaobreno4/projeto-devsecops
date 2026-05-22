# Security Group Corrigido (SSH restrito para a rede corporativa interna)
resource "aws_security_group" "api_sg" {
  name        = "api-security-group"
  description = "Security Group seguro para a API DevSecOps"

  ingress {
    description = "SSH permitido apenas via rede corporativa (Corrigido)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # <--- Agora está restrito e seguro!
  }

  ingress {
    description = "Porta da nossa API"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Permite saída para a internet para atualizações"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Bucket S3 Blindado
resource "aws_s3_bucket" "dados_api" {
  bucket        = "bucket-dados-sensiveis-api-lab-devsecops"
  force_destroy = true
}

# Criptografia por padrão no S3 (Corrige CKV_AWS_145)
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.dados_api.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Versionamento ativo no S3 (Corrige CKV_AWS_21)
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.dados_api.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Bloqueio TOTAL de acesso público (Corrigido para TRUE)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.dados_api.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
