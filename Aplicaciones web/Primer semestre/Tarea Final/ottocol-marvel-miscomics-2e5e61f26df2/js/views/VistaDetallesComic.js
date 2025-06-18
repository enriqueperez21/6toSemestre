Marvel.Views = Marvel.Views || {};

(function () {
    'use strict';

    Marvel.Views.VistaDetallesComic = Mn.ItemView.extend({
        template: '#VistaDetallesComicTmpl',

        events: {
            'click #botonCerrar': 'cerrarDetalles'
        },

        cerrarDetalles: function (e) {
            e.preventDefault();
            this.triggerMethod('hide:details');
        }
    });

    
})();