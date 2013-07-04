class Mapish.Views.Location extends Backbone.View

  template: JST['locations/location']

  events:
    'submit #new_location': 'createLocation'
    'click a.delete': 'deleteLocation'

  render: ->
    $(@el).html(@template(location: @model))
    this

  deleteLocation: ->
    event.preventDefault()
    $('#ac-' + @model.get('id')).parent().remove()
    @model.destroy()