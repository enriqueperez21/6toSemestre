/*global Marvel, Backbone*/

Marvel.Collections = Marvel.Collections || {};

(function () {
    'use strict';

    var TAM_LISTADO = 20;
    var OFFSET_LISTADO = 0;

    Marvel.Collections.Comics = Backbone.Collection.extend({
        model: Marvel.Models.Comic,
        url: Marvel.Constants.API_URL,
        parse: function(response, options) {
            return response.data.results;
        },
        buscar : async function(titulo, limit, offset) {
            limit = limit || TAM_LISTADO;
            offset = offset || OFFSET_LISTADO;
            this.fetch({data: $.param({
                    titleStartsWith: titulo,
                    limit: limit,
                    offset: offset,
                    apikey: Marvel.Constants.API_KEY
                })
            });
        }
    });

})();
