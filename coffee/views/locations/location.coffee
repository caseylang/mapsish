class Mapish.Views.Location extends Backbone.View

  template: JST['locations/location']

  render: ->
    $(@el).html(@template(location: @model))
    this