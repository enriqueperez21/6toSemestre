# API REST - Sistema de Reservas de Restaurante

## 🎯 Descripción

Esta API permite gestionar las reservas de salas en un restaurante. Se desarrolló con **Python + FastAPI**, utilizando **PostgreSQL** como base de datos.

## 🧰 Tecnologías

- FastAPI
- PostgreSQL
- SQLAlchemy
- Swagger UI
- Uvicorn

## 📌 Endpoints principales

- `GET /salas`: lista todas las salas
- `POST /reservas`: crea una nueva reserva
- `GET /reservas/mis-reservas`: lista todas las reservas
- `DELETE /reservas/{id}`: elimina una reserva

## ⚙️ Cómo ejecutar

1. Clona el repositorio
2. Crea entorno virtual
3. Instala dependencias
4. Configura `.env` con tu base de datos
5. Ejecuta con:
   ```bash
   uvicorn app.main:app --reload
