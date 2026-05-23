import os

print("--- Inicializando App do Laboratório DevSecOps ---")

# 💣 FALHA 1 (SAST/Semgrep): Uso de função perigosa 'eval' com input direto
# Isso abre brecha para injeção de código (RCE)
user_input = input("Digite um comando matemático: ")
resultado = eval(user_input)
print(f"Resultado: {resultado}")

# 💣 FALHA 2 (Secret Detection/Gitleaks): Chave de API exposta diretamente no código
# Nunca faça isso em produção!
AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

print("Conexão simulada com a AWS concluída com sucesso.")
