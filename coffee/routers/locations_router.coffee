class Mapish.Routers.Locations extends Backbone.Router
  routes:
    '': 'index'
    'locations/:id': 'show'

  index: ->
    view = new Mapish.Views.LocationsIndex()
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Location #{id}"