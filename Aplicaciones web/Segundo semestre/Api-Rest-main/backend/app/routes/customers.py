# routes/customers.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/customers", response_model=list[schemas.Customer])
def get_customers(db: Session = Depends(get_db)):
    return db.query(models.Customer).all()

@router.post("/customers", response_model=schemas.Customer)
def create_customer(customer: schemas.CustomerCreate, db: Session = Depends(get_db)):
    nuevo = models.Customer(**customer.dict())
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo