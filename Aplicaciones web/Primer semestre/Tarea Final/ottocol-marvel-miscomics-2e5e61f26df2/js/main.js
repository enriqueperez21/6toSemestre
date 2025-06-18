
var Marvel = {
    Constants: {
        API_URL: 'https://gateway.marvel.com/v1/public/comics',
        API_KEY: 'a6927e7e15930110aade56ef90244f6d'
    }
};


//Para poder usar Mustache con Marionette
Backbone.Marionette.Renderer.render = function(template,data) {
    return Mustache.render($(template).html(),data);
}



$('document').ready(function() {
    $(document).ready(function () {
    Marvel.vg = new Marvel.Views.VistaGlobal();
    Marvel.vg.showChildView('cabecera', new Marvel.Views.VistaFormLogin());

    // Mostrar el formulario de búsqueda desde el inicio
    Marvel.vg.showChildView('formBusqueda', new Marvel.Views.VistaBuscarComics());
});
});
