window.Mapish =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Mapish.Routers.Locations()
    Backbone.history.start()

$(document).ready ->
  Mapish.init()