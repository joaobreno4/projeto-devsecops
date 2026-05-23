# Projeto DevSecOps Pipeline

Este repositório contém um laboratório prático de implementação de uma esteira completa de CI/CD com foco em DevSecOps, cobrindo desde a análise estática de código até o escaneamento de vulnerabilidades em containers e infraestrutura como código (IaC).

A aplicação base consiste em uma API em Python desenvolvida com FastAPI.

---

## Tecnologias e Ferramentas Utilizadas

* **Linguagem e Framework:** Python e FastAPI
* **Infraestrutura como Código (IaC):** Terraform (configurações provisionadas na AWS)
* **Containerização:** Docker
* **Plataforma de CI/CD:** GitLab CI/CD
* **Versionamento:** Git e GitHub

---

## Pilares de Segurança Implementados (Shift-Left)

A esteira foi desenhada seguindo o conceito de Shift-Left, antecipando a segurança logo nas primeiras fases do desenvolvimento:

1. **Secret Detection (Detecção de Credenciais):** Utilização do Gitleaks para garantir que nenhuma chave de acesso da AWS, tokens ou credenciais sensíveis sejam injetadas no histórico do Git.
2. **SAST (Static Application Security Testing):** Integração com Semgrep para varredura contínua do código Python, prevenindo falhas graves como SQL Injection e o uso de funções inseguras (eval).
3. **IaC Security Scan:** Uso do Checkov para analisar os manifestos do Terraform (main.tf), validando políticas de conformidade, bloqueio de acesso público a buckets S3 e criptografia em repouso.
4. **Container Image Scan:** Implementação do Trivy no estágio pós-build da imagem Docker, mapeando e corrigindo vulnerabilidades (CVEs) críticas tanto no Sistema Operacional base (Debian) quanto nas dependências do requirements.txt.

---

## Estrutura do Pipeline (GitLab CI)

O fluxo da esteira está dividido em três estágios lógicos e automatizados:

* **test:** Execução paralela do gitleaks-scan, semgrep-sast e checkov-scan.
* **build:** Construção da imagem Docker utilizando a abordagem Docker-in-Docker (DinD) e geração do artefato da imagem.
* **security:** Escaneamento ativo da imagem gerada utilizando o trivy-scan para validação de pacotes.

---

## Como Executar Localmente

Se quiser rodar o projeto ou validar a estrutura na sua máquina:

```bash
# 1. Clone o repositório
git clone [https://github.com/joaobreno4/projeto-devsecops.git](https://github.com/joaobreno4/projeto-devsecops.git)

# 2. Acesse a pasta
cd projeto-devsecops

# 3. Construa a imagem Docker localmente
docker build -t api-devsecops:local .
