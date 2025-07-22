from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app import models, schemas

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/salas", response_model=list[schemas.Sala])
def listar_salas(db: Session = Depends(get_db)):
    return db.query(models.Sala).all()
