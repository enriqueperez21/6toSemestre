Marvel.Collections = Marvel.Collections || {};

Marvel.Models.Favorito = Backbone.Model.extend({
  defaults: {
    comic_id: '',
    title: '',
    thumbnail: {},
    description: ''
  },

  saveFavorito: async function (user_id) {
    console.log(user_id)
    const { error } = await supabase.from('favoritos').insert([{
      user_id: user_id,
      comic_id: this.get('comic_id'),
      title: this.get('title'),
      thumbnail: this.get('thumbnail'),
      description: this.get('description')
    }]);

    if (error) throw error;
  }
});