# app/models.py
from sqlalchemy import Column, Integer, String, ForeignKey, Float, DateTime
from sqlalchemy.orm import relationship
from app.database import Base
from datetime import datetime


class Sala(Base):
    __tablename__ = "salas"
    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String, unique=True, index=True)
    capacidad = Column(Integer)

class Reserva(Base):
    __tablename__ = "reservas"
    id = Column(Integer, primary_key=True, index=True)
    nombre_usuario = Column(String)
    sala_id = Column(Integer, ForeignKey("salas.id"))
    sala = relationship("Sala")


#codigo nuevo
class Menu(Base):
    __tablename__ = "menus"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    description = Column(String)

class Table(Base):
    __tablename__ = "tables"
    id = Column(Integer, primary_key=True, index=True)
    table_name = Column(String)
    location = Column(String)

class Customer(Base):
    __tablename__ = "customers"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    phone_number = Column(String)

class Booking(Base):
    __tablename__ = "bookings"
    id = Column(Integer, primary_key=True, index=True)
    customer_id = Column(Integer, ForeignKey("customers.id"))
    table_id = Column(Integer, ForeignKey("tables.id"))
    date = Column(DateTime)
    notes = Column(String)

    customer = relationship("Customer")
    table = relationship("Table")

class Order(Base):
    __tablename__ = "orders"
    id = Column(Integer, primary_key=True, index=True)
    order_type = Column(String)  # "takeaway", "shopping", "eatin"
    menu_item_id = Column(Integer, ForeignKey("menus.id"))
    customer_id = Column(Integer, ForeignKey("customers.id"))
    table_id = Column(Integer, ForeignKey("tables.id"), nullable=True)

    menu_item = relationship("Menu")
    customer = relationship("Customer")
    table = relationship("Table")

class Waiter(Base):
    __tablename__ = "waiters"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    experience_years = Column(Integer)
