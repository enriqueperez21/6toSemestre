var PokemonView = Backbone.View.extend({
    initialize: function(){
        this.listenTo(this.model, 'change:dt', this.renderData);
    },
    render: function(){
        this.$el.html(
            '<input type="text" id="nombre_pokemon" placeholder="Escriba un pokemón para buscar">'+
            '<input type="button" value="Buscar" id="buscar_pokemon">'+
            '<div><img id="pokemon_img" src="" alt="imagen pokemon"></div>'+
            '<div id="info_pokemon"></div>'
        );
        return this;
    },
    events:{
        "click #buscar_pokemon":"buscarPokemon"
    },
    buscarPokemon: function(){
        var nombre = $('#nombre_pokemon').val();
        this.model.set("nombre", nombre);
        this.model.obtenerDatos();
    },
    renderData: function(){
        $('#pokemon_img').attr('src', this.model.get('imagen'));
        $('#info_pokemon').html(`
            <p><strong>Tipo: </strong>${this.model.get('tipo')}</p>
            <p><strong>Altura: </strong>${this.model.get('altura')} dm</p>
            <p><strong>Peso: </strong>${this.model.get('peso')} hg</p>
        `);
    }
});

//inicializar el modelo y la vida
//modelo
var miPokemon = new PokemonModel();
//vista
var miVistaPokemon = new PokemonView({model:miPokemon});

$('#pokemon_widget').html(miVistaPokemon.render().$el);