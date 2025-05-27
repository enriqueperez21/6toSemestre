var TiempoWidget = Backbone.View.extend({
    initialize: function(){
        this.listenTo(this.model, 'change:dt', this.renderData);
    },
    render: function(){
        this.$el.html(
            '<input type="text" id="localidad" placeholder="escriba una localidad">'+
            '<input type="button" value="Ver tiempo" id="ver_tiempo">'+
            '<div><img id="icono" src="" alt="icono del clima"></div>'+
            '<div id="descripcion"></div>'
        );
        return this;
    },
    renderData:function(){
        $('#icono').attr('src',this.model.get("icono_url"));
        $('#descripcion').html(this.model.get("descripcion"));
    },
    events:{
        "click #ver_tiempo":"ver_tiempo_de"
    },
    ver_tiempo_de: function(){
        this.model.set("localidad", $("#localidad").val());
        this.model.actualizarTiempo();
    }
});

//inicializar el modelo y la vida
//modelo
var miTiempo = new DatosTiempo();
//vista
var miWidget = new TiempoWidget({model:miTiempo});

$('#tiempo_widget').html(miWidget.render().$el);