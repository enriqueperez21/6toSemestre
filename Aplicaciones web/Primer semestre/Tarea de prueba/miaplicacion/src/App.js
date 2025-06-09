import logo from './logo.svg';
import './App.css';
import Saludo from './Saludo';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h1>React</h1>
        
      </header>
      <Saludo/>
    </div>
  );
}

export default App;
