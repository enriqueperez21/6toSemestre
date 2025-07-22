from fastapi import FastAPI
from app.database import engine, Base
from app.routes import salas, reservas, menu, bookings, tables, customers, orders
from fastapi.middleware.cors import CORSMiddleware


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],  # o ["*"] si es solo desarrollo
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# Crea las tablas automaticamente en PostgreSQL
Base.metadata.create_all(bind=engine)

# Rutas
app.include_router(salas.router)
app.include_router(reservas.router)
app.include_router(menu.router)
app.include_router(bookings.router)
app.include_router(tables.router)
app.include_router(customers.router)
app.include_router(orders.router)
