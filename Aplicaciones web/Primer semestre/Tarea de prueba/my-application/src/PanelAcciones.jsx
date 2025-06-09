import React from "react"

function PaneAcciones(props){
    return(
        <div style={{
            border: '1px solid $ddd',
            padding: '1rem',
            borderRadius: '8px',
            textAlign: 'center',
            width: '300px',
            margin: '1rem auto'
            }}
        >
            <h2>{props.titulo}</h2>
            <button onClick={props.onGuardar} style={{marginRight: '10px'}}>
                Guardar
            </button>
            <button onClick={props.onCancelar}>
                Cancelar
            </button>
        </div>
    )
}

export default PaneAcciones