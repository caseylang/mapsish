class Mapish.Views.LocationsIndex extends Backbone.View

  template: JST['locations/index']

  events:
    'submit #new_location': 'createLocation'
    'click #delete': 'deleteLocation'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendLocation, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendLocation)
    this

  appendLocation: (location) ->
    # if location.isNew()
    #   location = location.get('locations')[0]
    # else
    #   location = location.toJSON()
    view = new Mapish.Views.Location(model: location)
    $('#locations').append(view.render().el)

  createLocation: (event) ->
    event.preventDefault()
    $('#new_location_name').removeClass('error').addClass('line')
    $('#new_location_address').removeClass('error').addClass('line')
    $('small').remove()
    attributes = {name: $('#new_location_name').val(), address: $('#new_location_address').val()}
    @collection.create attributes,
      wait: true
      success: -> $('#new_location')[0].reset()
      error: @handleError

  deleteLocation: (event) ->
    event.preventDefault()
    id = event.currentTarget.value
    console.log id
    console.log @collection
    l = @collection.findWhere({'id': id})
    console.log l
    # location.destroy

  handleError: (location, response) ->
    if response.status == 422
      errors  = $.parseJSON(response.responseText).errors
      for index, error of errors
        $('#new_location_' + error.key).removeClass('line').addClass('error')
        $('#new_location_' + error.key).after '<small class="error">' + error.message + '</small>'