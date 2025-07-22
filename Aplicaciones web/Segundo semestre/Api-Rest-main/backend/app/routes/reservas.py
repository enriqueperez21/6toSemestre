from fastapi import APIRouter, Depends, HTTPException
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

@router.post("/reservas", response_model=schemas.Reserva)
def crear_reserva(reserva: schemas.ReservaCreate, db: Session = Depends(get_db)):
    nueva = models.Reserva(**reserva.dict())
    db.add(nueva)
    db.commit()
    db.refresh(nueva)
    return nueva

@router.get("/reservas/mis-reservas", response_model=list[schemas.Reserva])
def obtener_reservas(db: Session = Depends(get_db)):
    return db.query(models.Reserva).all()

@router.delete("/reservas/{id}")
def eliminar_reserva(id: int, db: Session = Depends(get_db)):
    reserva = db.query(models.Reserva).get(id)
    if not reserva:
        raise HTTPException(status_code=404, detail="No encontrada")
    db.delete(reserva)
    db.commit()
    return {"ok": True}
