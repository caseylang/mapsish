class Mapish.Routers.Locations extends Backbone.Router
  routes:
    '': 'index'
    'locations/:id': 'show'

  initialize: ->
    @collection = new Mapish.Collections.Locations()
    @collection.fetch({reset: true})

  index: ->
    view = new Mapish.Views.LocationsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Location #{id}"