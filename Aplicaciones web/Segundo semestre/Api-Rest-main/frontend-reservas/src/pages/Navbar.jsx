import { Link } from 'react-router-dom';

export default function Navbar() {
  return (
    <nav style={{ padding: '10px', background: '#eee' }}>
      <Link to="/" style={{ margin: '0 10px' }}>Mesas</Link>
      <Link to="/menu" style={{ margin: '0 10px' }}>Menú</Link>
      <Link to="/pedidos" style={{ margin: '0 10px' }}>Pedidos</Link>
      <Link to="/reservar" style={{ margin: '0 10px' }}>Reservar Mesa</Link>
      <Link to="/mis-reservas" style={{ margin: '0 10px' }}>Reservas Registradas</Link>
    </nav>
  );
}
