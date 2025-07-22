import { useEffect, useState } from 'react';
import api from '../api';

export default function Pedidos() {
  const [clientes, setClientes] = useState([]);
  const [menus, setMenus] = useState([]);
  const [mesas, setMesas] = useState([]);
  const [pedidos, setPedidos] = useState([]);
  const [mostrarFormulario, setMostrarFormulario] = useState(false);

  const [pedido, setPedido] = useState({
    customer_id: '',
    menu_item_id: '',
    table_id: '',
    order_type: ''
  });

  useEffect(() => {
    api.get('/customers').then(res => setClientes(res.data));
    api.get('/menu').then(res => setMenus(res.data));
    api.get('/tables').then(res => setMesas(res.data));
    api.get('/orders').then(res => setPedidos(res.data));
  }, []);

  const enviarPedido = () => {
    api.post('/orders', pedido)
      .then(() => {
        alert('Pedido registrado');
        setPedido({ customer_id: '', menu_item_id: '', table_id: '', order_type: '' });
        setMostrarFormulario(false);
        api.get('/orders').then(res => setPedidos(res.data)); // actualizar lista
      })
      .catch(() => alert('Error al registrar pedido'));
  };

  const getNombre = (id, lista) => {
    const item = lista.find(x => x.id === parseInt(id));
    return item ? item.name || item.table_name : 'Desconocido';
  };

  return (
    <div style={{ marginTop: 30 }}>
      <button onClick={() => setMostrarFormulario(!mostrarFormulario)}>
        {mostrarFormulario ? 'Ver Pedidos' : 'Registrar Nuevo Pedido'}
      </button>

      {mostrarFormulario ? (
        <div>
          <h2>Registrar Pedido</h2>

          <select name="customer_id" value={pedido.customer_id} onChange={e => setPedido({ ...pedido, customer_id: e.target.value })}>
            <option value="">Seleccionar cliente</option>
            {clientes.map(c => (
              <option key={c.id} value={c.id}>{c.name}</option>
            ))}
          </select><br />

          <select name="menu_item_id" value={pedido.menu_item_id} onChange={e => setPedido({ ...pedido, menu_item_id: e.target.value })}>
            <option value="">Seleccionar platillo</option>
            {menus.map(m => (
              <option key={m.id} value={m.id}>{m.name}</option>
            ))}
          </select><br />

          <select name="table_id" value={pedido.table_id} onChange={e => setPedido({ ...pedido, table_id: e.target.value })}>
            <option value="">Seleccionar mesa</option>
            {mesas.map(m => (
              <option key={m.id} value={m.id}>{m.table_name}</option>
            ))}
          </select><br />

          <select name="order_type" value={pedido.order_type} onChange={e => setPedido({ ...pedido, order_type: e.target.value })}>
            <option value="">Seleccionar tipo de pedido</option>
            <option value="presencial">Presencial</option>
            <option value="para llevar">Para llevar</option>
          </select><br />

          <button onClick={enviarPedido}>Guardar Pedido</button>
        </div>
      ) : (
        <div>
          <h2>Pedidos Registrados</h2>
          <ul>
            {pedidos.map(p => (
              <li key={p.id}>
                Cliente: {getNombre(p.customer_id, clientes)} | Platillo: {getNombre(p.menu_item_id, menus)} | Mesa: {getNombre(p.table_id, mesas)} | Tipo: {p.order_type}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}