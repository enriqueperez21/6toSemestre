from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app import models, schemas

router = APIRouter()

@router.get("/menu", response_model=list[schemas.Menu])
def get_menus(db: Session = Depends(get_db)):
    return db.query(models.Menu).all()

@router.post("/menu", response_model=schemas.Menu)
def create_menu(menu: schemas.MenuCreate, db: Session = Depends(get_db)):
    nuevo = models.Menu(**menu.dict())
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo
