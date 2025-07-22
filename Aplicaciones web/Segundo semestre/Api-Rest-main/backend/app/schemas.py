# app/schemas.py
from pydantic import BaseModel

from datetime import datetime
from typing import Optional


class SalaBase(BaseModel):
    nombre: str
    capacidad: int

class SalaCreate(SalaBase): pass

class Sala(SalaBase):
    id: int
    class Config:
        from_attributes = True

class ReservaBase(BaseModel):
    nombre_usuario: str
    sala_id: int

class ReservaCreate(ReservaBase): pass

class Reserva(ReservaBase):
    id: int
    class Config:
        from_attributes = True

# Menu
class MenuBase(BaseModel):
    name: str
    description: str

class MenuCreate(MenuBase): pass

class Menu(MenuBase):
    id: int
    class Config:
        from_attributes = True

# Table
class TableBase(BaseModel):
    table_name: str
    location: str

class TableCreate(TableBase): pass

class Table(TableBase):
    id: int
    class Config:
        from_attributes = True

# Customer
class CustomerBase(BaseModel):
    name: str
    phone_number: str

class CustomerCreate(CustomerBase): pass

class Customer(CustomerBase):
    id: int
    class Config:
        from_attributes = True

# Booking
from datetime import datetime

class BookingBase(BaseModel):
    customer_id: int
    table_id: int
    date: datetime
    notes: Optional[str] = None

class BookingCreate(BookingBase): pass

class Booking(BookingBase):
    id: int
    class Config:
        from_attributes = True

# Order
class OrderBase(BaseModel):
    order_type: str
    menu_item_id: int
    customer_id: int
    table_id: Optional[int] = None


class OrderCreate(OrderBase): pass

class Order(OrderBase):
    id: int
    class Config:
        from_attributes = True

# Waiter
class WaiterBase(BaseModel):
    name: str
    experience_years: int

class WaiterCreate(WaiterBase): pass

class Waiter(WaiterBase):
    id: int
    class Config:
        from_attributes = True