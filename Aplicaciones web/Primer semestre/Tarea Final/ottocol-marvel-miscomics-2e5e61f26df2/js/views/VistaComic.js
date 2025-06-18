Marvel.Views = Marvel.Views || {};

(function () {
    'use strict';

    Marvel.Views.VistaComic = Mn.ItemView.extend({
        template: '#VistaComicTmpl',

        events: {
                'click #guardarFav': 'guardarFavorito',
                'click #verDetalles': 'verDetalles'
            },
            
        verDetalles: function (e) {
            e.preventDefault();
            this.triggerMethod('show:details', this.model);
        },
        
        guardarFavorito: async function (e) {
            e.preventDefault();

            const usuario = Marvel.vg.usuario;
            if (!usuario) return alert('Debes iniciar sesión primero.');

            const fav = new Marvel.Models.Favorito({
                comic_id: this.model.id,
                title: this.model.get('title'),
                thumbnail: this.model.get('thumbnail'),
                description: this.model.get('description')
            });

            try {
                await fav.saveFavorito(usuario.get('id'));
                alert('Guardado como favorito');
            } catch (error) {
                alert('Error de login: ' + (error.message || JSON.stringify(error)));
            }
        }
    });

})();
