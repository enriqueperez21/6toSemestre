Marvel.Views = Marvel.Views || {};

(function () {
  'use strict';

  Marvel.Views.VistaCabecera = Mn.ItemView.extend({
    template: '#VistaCabeceraTmpl', // asegúrate de tener esta plantilla

    events: {
      'click #verMisComics': 'mostrarFavoritos',
      'click #cerrarSesion': 'logout'
    },

    mostrarFavoritos: function (e) {
      e.preventDefault();
      this.triggerMethod('ver:favoritos');
    },

    logout: async function (e) {
      e.preventDefault();
      await supabase.auth.signOut();
      this.triggerMethod('logout:success');
    }
  });
})();