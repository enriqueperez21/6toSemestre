import { useState } from 'react';
import api from '../api';

export default function Reservar() {
  const [form, setForm] = useState({ sala_id: '', nombre_usuario: '' });

  const handleChange = e => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const reservar = () => {
    api.post('/reservas', form)
      .then(() => alert('Reserva realizada'))
      .catch(err => alert('Error al reservar'));
  };

  return (
    <div>
      <h2>Reservar Sala</h2>
      <input name="sala_id" placeholder="ID Sala" onChange={handleChange} /><br />
      <input name="nombre_usuario" placeholder="Nombre del Usuario" onChange={handleChange} /><br />
      <button onClick={reservar}>Reservar</button>
    </div>
  );
}