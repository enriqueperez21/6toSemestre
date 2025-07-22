import { useEffect, useState } from 'react';
import api from '../api';

export default function MisReservas() {
  const [reservas, setReservas] = useState([]);
  const [clientes, setClientes] = useState([]);
  const [mesas, setMesas] = useState([]);

  useEffect(() => {
    cargarReservas();
    api.get('/customers').then(res => setClientes(res.data));
    api.get('/tables').then(res => setMesas(res.data));
  }, []);

  const cargarReservas = () => {
    api.get('/bookings')
      .then(res => setReservas(res.data))
      .catch(err => console.error(err));
  };

  const getNombreMesa = (id) => {
    const mesa = mesas.find(m => m.id === id);
    return mesa ? mesa.table_name : id;
  };

  const getNombreCliente = (id) => {
    const cliente = clientes.find(c => c.id === id);
    return cliente ? cliente.name : id;
  };

  const formatearFecha = (isoDate) => {
    const fecha = new Date(isoDate);
    const opciones = { day: '2-digit', month: '2-digit', year: 'numeric' };
    const hora = fecha.toTimeString().slice(0, 5); // HH:MM
    return `${fecha.toLocaleDateString('es-ES', opciones)} ${hora}`;
  };

  return (
    <div>
      <h2>Reservas Registradas</h2>
      <ul>
        {reservas.map(r => (
          <li key={r.id}>
            Cliente: {getNombreCliente(r.customer_id)} - {getNombreMesa(r.table_id)} - Fecha: {formatearFecha(r.date)}
          </li>
        ))}
      </ul>
    </div>
  );
}
