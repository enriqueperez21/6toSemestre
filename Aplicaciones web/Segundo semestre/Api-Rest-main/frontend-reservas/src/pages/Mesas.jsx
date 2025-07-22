import { useEffect, useState } from "react";
import api from "../api";

export default function Mesas() {
  const [mesas, setMesas] = useState([]);

  useEffect(() => {
    api.get("/tables")
      .then(res => setMesas(res.data))
      .catch(err => console.error("Error al cargar mesas:", err));
  }, []);

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold mb-4">Mesas disponibles</h1>
      <ul className="space-y-2">
        {mesas.map(mesa => (
          <li key={mesa.id} className="border p-2 rounded shadow">
            <strong>Nombre:</strong> {mesa.table_name}<br />
            <strong>Ubicación:</strong> {mesa.location}
          </li>
        ))}
      </ul>
    </div>
  );
}
