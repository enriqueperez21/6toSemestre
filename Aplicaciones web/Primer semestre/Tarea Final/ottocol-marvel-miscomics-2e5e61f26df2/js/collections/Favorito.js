Marvel.Collections = Marvel.Collections || {};

Marvel.Collections.Favoritos = Backbone.Collection.extend({
  model: Marvel.Models.Favorito,

  fetchFavoritos: async function () {
    const { data, error } = await supabase.from('favoritos').select('*');
    if (error) throw error;
    this.reset(data); // carga los datos en la colección
  }
});