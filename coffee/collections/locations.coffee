class Mapish.Collections.Locations extends Backbone.Collection
  url: '/api/locations'

  parse: (response) ->
    response.locations