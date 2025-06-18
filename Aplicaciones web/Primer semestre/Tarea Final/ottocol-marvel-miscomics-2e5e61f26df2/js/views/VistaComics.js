
//Vista pensada para mostrar una lista de comics.
//Pueden ser resultados de búsqueda o la lista de "mis comics"

Marvel.Views = Marvel.Views || {};

(function () {
    'use strict';

    Marvel.Views.VistaComics = Mn.CompositeView.extend({
        template: '#VistaComicsTmpl',            // la nueva plantilla
        childView: Marvel.Views.VistaComic,      // vista hija
        childViewContainer: '.contenedor-comics' // dónde van las vistas hijas
    });
})();