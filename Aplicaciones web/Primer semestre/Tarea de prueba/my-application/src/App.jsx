import { useState } from 'react'
//import reactLogo from './assets/react.svg'
//import viteLogo from '/vite.svg'
import './App.css'
import Saludo from './Saludo'
import Saludo1 from './Saludo1'
import MiBoton from './MiBoton'
import BotonPersonalizado from './BotonPersonalizado'
import PaneAcciones from './PanelAcciones'
import ListaQuimicos from './ListaQuimicos'
import { BrowserRouter, Link, Route, Routes } from 'react-router-dom'
import About from './About'
import Contact from './Contact'

function App() {
  //const [count, setCount] = useState(0)

  const guardar = () =>{
    alert('Guardado exitosamente')
  };

  const cancelar = ()=>{
    alert('Operación cancelada')  
  }

  return (
    <>
      <BrowserRouter>
        <nav>
          <ul>
      
            <li><Link to="/about">About</Link></li>
            <li><Link to="/contact">Contact</Link></li>
                </ul>
        </nav>
        <Routes>
          <Route path="/about" element={<About />}/>
          <Route path="/contact" element={<Contact />}/>
        </Routes>
      </BrowserRouter>
      <div>
        <h1>Hola mundo desde React</h1>
        <p>Aplicación usando Vite</p>
      </div>
      <h2>Saludo desde un componente funcitonal</h2>
      <Saludo nombre={"Enrique"} />
      <h2>Saludo desde un componente con clases</h2>
      <Saludo1 nombre={"Enrique"}/>
      <MiBoton onClick={()=> alert ('Haz hecho clic')}>
        Haz click aquí
      </MiBoton>
      <BotonPersonalizado onClick={()=> alert ('Haz hecho clic')}>
        Haz click aquí
      </BotonPersonalizado>
      <div>
      </div>
        <PaneAcciones 
          titulo="Desea continuar?"
          onGuardar = {guardar}
          onCancelar = {cancelar}
        />
      <h2>Ejemplo de consumo de arrays</h2>
      <ListaQuimicos/>
    </>
  )
}

export default App
