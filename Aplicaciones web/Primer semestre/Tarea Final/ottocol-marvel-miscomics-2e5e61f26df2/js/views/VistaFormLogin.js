Marvel.Views = Marvel.Views || {};

(function () {
    'use strict';

    Marvel.Views.VistaFormLogin = Mn.ItemView.extend({
        template: '#VistaFormLoginTmpl',

        events: {
            'click #botonLogin': 'login'
        },

        login: async function (e) {
            e.preventDefault();

            const modelo = new Marvel.Models.Usuario({
                email: this.$('#email').val(),
                password: this.$('#password').val()
            });

            try {
                await modelo.login(); // Método propio que usa save()
                this.triggerMethod('login:success', modelo); // Enviar modelo a la vista global
            } catch (error) {
                alert('Error de login: ' + (error.message || JSON.stringify(error)));
            }
        }
    });


})();