import React from "react";

class Saludo1 extends React.Component{
    //atributos

    //renderizar el componente el vista
    render(){
        const {nombre} = this.props;
        return <p>Hola {nombre} Bienvenido a mi aplicación web</p> 
    }
}

export default Saludo1