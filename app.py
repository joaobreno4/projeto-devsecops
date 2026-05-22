from fastapi import FastAPI, Depends
import sqlite3

app = FastAPI(title="DevSecOps Lab API")

# Banco de dados em memória para testes rápidos
def get_db():
    conn = sqlite3.connect(":memory:")
    cursor = conn.cursor()
    cursor.execute("CREATE TABLE users (id INTEGER, username TEXT, password TEXT)")
    cursor.execute("INSERT INTO users VALUES (1, 'admin', 'admin123')")
    conn.commit()
    try:
        yield cursor
    finally:
        conn.close()

@app.get("/")
def read_root():
    return {"status": "healthy", "message": "Pipeline DevSecOps Ativo!"}

# ALERTA DE VULNERABILIDADE: Concatenção direta de string (SQL Injection proposital)
@app.get("/vulnerable-login")
def vulnerable_login(username: str, db = Depends(get_db)):
    query = f"SELECT * FROM users WHERE username = '{username}'"
    db.execute(query)
    user = db.fetchone()
    if user:
        return {"success": True, "user": user[1]}
    return {"success": False, "message": "Usuário não encontrado"}
