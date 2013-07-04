class Mapish.Views.Location extends Backbone.View

  template: JST['locations/location']

  events:
    'submit #new_location': 'createLocation'
    'click a.delete': 'deleteLocation'
    'change input[name=\'name\']': 'updateName'
    'change input[name=\'address\']': 'updateAddress'

  initialize: ->
    @model.on('change:address', @render, this)

  render: ->
    $(@el).html(@template(location: @model))
    this

  updateName: (event) ->
    event.preventDefault()
    value = event.target.value
    @model.set({'name': value})
    @model.save()

  updateAddress: (event) ->
    event.preventDefault()
    value = event.target.value
    @model.save({'address': value}, {wait: true})

  deleteLocation: (event) ->
    event.preventDefault()
    $('#ac-' + @model.get('id')).parent().remove()
    @model.destroy()