import React from "react"

class BotonPersonalizado extends React.Component{
    //Sin estado.

    render(){
        const estilo ={
            background: 'green',
            color: 'red'
        };
    return(
            <h3>
                <button {...this.props} style={estilo}>
                    {this.props.children}
                </button>
            </h3>
        )
    }
}

export default BotonPersonalizado