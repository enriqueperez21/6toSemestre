Marvel.Views = Marvel.Views || {};

(function () {
    'use strict';

    Marvel.Views.VistaGlobal = Mn.LayoutView.extend({
        template: false,
        el: 'body',

        regions: {
            cabecera: '#cabecera',
            formBusqueda: '#formBusqueda',
            listado: '#listado'
        },

        childEvents: {
            'login:success': function(child, user) {
                this.usuario = user;
                this.showChildView('cabecera', new Marvel.Views.VistaCabecera({ model: user }));
            },
            'completed:search': function (child, col) {
                this.showChildView('listado', new Marvel.Views.VistaComics({
                    collection: col
                }));
            },
            'show:details': function(child, model) {
                this.vistaLista = this.getRegion('listado').currentView;
                const nv = new Marvel.Views.VistaDetallesComic({model});
                this.getRegion('listado').show(nv, { preventDestroy: true });
            },
    
            'hide:details': function() {
                this.getRegion('listado').show(this.vistaLista);
            },
            'ver:favoritos': async function () {
                const favoritos = new Marvel.Collections.Favoritos();
                await favoritos.fetchFavoritos();

                this.showChildView('listado', new Marvel.Views.VistaComics({
                    collection: favoritos
                }));
            },
            
            'logout:success': function () {
                this.usuario = null;
                this.showChildView('cabecera', new Marvel.Views.VistaFormLogin());
                this.getRegion('listado').empty();
            },
        },
    });
})();