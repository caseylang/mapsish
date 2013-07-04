class Mapish.Views.LocationsIndex extends Backbone.View

  template: JST['locations/index']

  events:
    'submit #new_location': 'createLocation'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendLocation, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendLocation)
    this

  appendLocation: (location) ->
    if location.isNew()
      location = location.get('locations')[0]
    else
      location = location.toJSON()
    view = new Mapish.Views.Location(model: location)
    $('#locations').append(view.render().el)

  createLocation: (event) ->
    event.preventDefault()
    @collection.create({name: $('#new_location_name').val(), address: $('#new_location_address').val()}, {wait: true})
    $('#new_location')[0].reset()