# routes/tables.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/tables", response_model=list[schemas.Table])
def get_tables(db: Session = Depends(get_db)):
    return db.query(models.Table).all()

@router.post("/tables", response_model=schemas.Table)
def create_table(table: schemas.TableCreate, db: Session = Depends(get_db)):
    nuevo = models.Table(**table.dict())
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo