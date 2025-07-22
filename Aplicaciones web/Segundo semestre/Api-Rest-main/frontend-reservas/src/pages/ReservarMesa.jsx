import { useState, useEffect } from 'react';
import api from '../api';

export default function ReservarMesa() {
  const [form, setForm] = useState({
    customer_id: '',
    table_id: '',
    date: '',
    notes: ''
  });
  const [clientes, setClientes] = useState([]);
  const [mesas, setMesas] = useState([]);

  useEffect(() => {
    api.get('/customers').then(res => setClientes(res.data));
    api.get('/tables').then(res => setMesas(res.data));
  }, []);

  const handleChange = e => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const reservar = () => {
    api.post('/bookings', form)
      .then(() => alert('Reserva creada'))
      .catch(() => alert('Error al reservar'));
  };

  return (
    <div>
      <h2>Reservar Mesa</h2>
      <select name="customer_id" onChange={handleChange}>
        <option value="">Seleccione Cliente</option>
        {clientes.map(c => (
          <option key={c.id} value={c.id}>{c.name}</option>
        ))}
      </select><br />

      <select name="table_id" onChange={handleChange}>
        <option value="">Seleccione Mesa</option>
        {mesas.map(t => (
          <option key={t.id} value={t.id}>{t.table_name}</option>
        ))}
      </select><br />

      <input type="datetime-local" name="date" onChange={handleChange} /><br />
      <input type="text" name="notes" placeholder="Notas" onChange={handleChange} /><br />
      <button onClick={reservar}>Reservar</button>
    </div>
  );
}
