Marvel.Models = Marvel.Models || {};

(function () {
  'use strict';

  Marvel.Models.Usuario = Backbone.Model.extend({
    login: async function () {
      const { data, error } = await supabase.auth.signInWithPassword({
        email: this.get('email'),
        password: this.get('password')
      });

      if (error) throw error;
      this.set('id', data.user.id); // guarda el id del usuario
    },

    logout: async function () {
      await supabase.auth.signOut();
    }
  });
})();