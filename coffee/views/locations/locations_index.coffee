class Mapish.Views.LocationsIndex extends Backbone.View

  template: JST['locations/index']

  events:
    'submit #new_location': 'createLocation'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(locations: @collection.toJSON()))
    this

  createLocation: (event) ->
    event.preventDefault()
    @collection.create({name: $('#new_location_name').val(), address: $('#new_location_address').val()})