import React, { useEffect, useState } from "react";
import axios from "axios";

const SalasView = () => {
  const [salas, setSalas] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    axios.get("http://127.0.0.1:8000/salas")
      .then(response => {
        setSalas(response.data);
      })
      .catch(error => {
        setError("Error al cargar las salas.");
        console.error(error);
      });
  }, []);

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold mb-4">Listado de Salas</h1>
      {error && <p className="text-red-500">{error}</p>}
      <ul className="space-y-2">
        {salas.map((sala, index) => (
          <li key={index} className="border p-2 rounded shadow">
            <strong>Nombre:</strong> {sala.nombre}<br />
            <strong>Capacidad:</strong> {sala.capacidad}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default SalasView;
