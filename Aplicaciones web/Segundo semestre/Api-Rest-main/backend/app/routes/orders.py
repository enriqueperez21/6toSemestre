# routes/orders.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/orders", response_model=list[schemas.Order])
def get_orders(db: Session = Depends(get_db)):
    return db.query(models.Order).all()

@router.post("/orders", response_model=schemas.Order)
def create_order(order: schemas.OrderCreate, db: Session = Depends(get_db)):
    nuevo = models.Order(**order.dict())
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo
