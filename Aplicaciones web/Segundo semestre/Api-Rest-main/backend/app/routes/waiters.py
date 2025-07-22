# routes/waiters.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/waiters", response_model=list[schemas.Waiter])
def get_waiters(db: Session = Depends(get_db)):
    return db.query(models.Waiter).all()

@router.post("/waiters", response_model=schemas.Waiter)
def create_waiter(waiter: schemas.WaiterCreate, db: Session = Depends(get_db)):
    nuevo = models.Waiter(**waiter.dict())
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo