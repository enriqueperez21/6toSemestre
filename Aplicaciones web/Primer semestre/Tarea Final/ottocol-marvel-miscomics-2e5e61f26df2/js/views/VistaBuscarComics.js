Marvel.Views = Marvel.Views || {};

(function () {
    'use strict';

    Marvel.Views.VistaBuscarComics = Mn.ItemView.extend({
        template: '#VistaBuscarComicsTmpl',

        events: {
            'click #botonBuscar': 'buscar'
        },

        initialize: function () {
            this.collection = new Marvel.Collections.Comics();

            // Escucha el evento "sync" para saber cuándo terminan de llegar los datos
            this.listenTo(this.collection, 'sync', this.busquedaCompletada.bind(this));
        },

        buscar: async function (e) {
            e.preventDefault();
            const texto = this.$('#titulo').val();

            if (texto.trim() !== '') {
                await this.collection.buscar(texto);
            } else {
                alert('Por favor escribe un título para buscar.');
            }
        },

        busquedaCompletada: function () {
            // Envía la colección a la VistaGlobal
            this.triggerMethod('completed:search', this.collection);
            // "Debug"
            console.log(this.collection)
        }
    });

})();