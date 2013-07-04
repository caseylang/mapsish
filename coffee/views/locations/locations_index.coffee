class Mapish.Views.LocationsIndex extends Backbone.View

  template: JST['locations/index']

  render: ->
    $(@el).html(@template())
    this