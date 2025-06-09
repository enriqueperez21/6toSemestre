import React from "react"

class MiBoton extends React.Component{
    constructor(props){
        super(props)
        this.state ={
            style:{
                background: 'blue',
                color: 'white'
            }
        };
    }
    render(){
        return(
            <h3>
                <button {...this.props} style={this.state.style}>
                    {this.props.children}
                </button>
            </h3>
        );
    }
}

export default MiBoton