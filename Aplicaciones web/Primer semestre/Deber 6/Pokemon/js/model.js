var URL_API = "https://pokeapi.co/api/v2/pokemon/";

var PokemonModel=Backbone.Model.extend({
    obtenerDatos: function() {
        var nombre=this.get('nombre').toLowerCase();
        $.getJSON(URL_API + nombre)
            .done((data) => {
                this.set({
                    imagen: data.sprites.front_default,
                    tipo: data.types[0].type.name,
                    altura: data.height,
                    peso: data.weight
                });
                this.set('dt', Date.now()); //Disparador
            })
            .fail(()=>{
                alert("Pokemon no encontrado")
            })
    }

});