# routes/bookings.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/bookings", response_model=list[schemas.Booking])
def get_bookings(db: Session = Depends(get_db)):
    return db.query(models.Booking).all()

@router.post("/bookings", response_model=schemas.Booking)
def create_booking(booking: schemas.BookingCreate, db: Session = Depends(get_db)):
    nuevo = models.Booking(**booking.dict())
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo