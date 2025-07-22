import { useEffect, useState } from 'react';
import api from '../api';

export default function Menu() {
  const [menu, setMenu] = useState([]);
  const [mostrarAgregar, setMostrarAgregar] = useState(false);
  const [nuevo, setNuevo] = useState({ name: '', description: '' });

  useEffect(() => {
    api.get('/menu').then(res => setMenu(res.data));
  }, []);

  const agregar = () => {
    api.post('/menu', nuevo).then(() => {
      alert('Platillo agregado');
      setNuevo({ name: '', description: '' });
      setMostrarAgregar(false);
      api.get('/menu').then(res => setMenu(res.data)); // actualizar lista
    });
  };

  return (
    <div style={{marginTop:30}}>
      <button onClick={() => setMostrarAgregar(!mostrarAgregar)}>
        {mostrarAgregar ? 'Ver Menú' : 'Agregar Platillo'}
      </button>

      {mostrarAgregar ? (
        <div>
          <h2>Agregar platillo</h2>
          <input
            placeholder="Nombre"
            value={nuevo.name}
            onChange={e => setNuevo({ ...nuevo, name: e.target.value })}
          /><br />
          <input
            placeholder="Descripción"
            value={nuevo.description}
            onChange={e => setNuevo({ ...nuevo, description: e.target.value })}
          /><br />
          <button onClick={agregar}>Guardar</button>
        </div>
      ) : (
        <div>
          <h2>Menú Mexicano</h2>
          <ul>
            {menu.map(item => (
              <li key={item.id}>
                {item.name} - {item.description}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}