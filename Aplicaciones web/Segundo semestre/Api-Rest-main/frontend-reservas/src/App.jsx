import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Navbar from './pages/Navbar';
import Mesas from './pages/Mesas';
import Menu from './pages/Menu';
import Pedidos from './pages/Pedidos';
import ReservarMesa from './pages/ReservarMesa';
import MisReservas from './pages/MisReservas';
import './index.css';

export default function App() {
  return (
    <BrowserRouter>
      <Navbar />
      <Routes>
        <Route path="/" element={<Mesas />} />
        <Route path="/menu" element={<Menu />} />
        <Route path="/pedidos" element={<Pedidos />} />
        <Route path="/reservar" element={<ReservarMesa />} />
        <Route path="/mis-reservas" element={<MisReservas />} />
      </Routes>
    </BrowserRouter>
  );
}
