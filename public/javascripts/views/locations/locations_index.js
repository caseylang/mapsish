// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Mapish.Views.LocationsIndex = (function(_super) {
    __extends(LocationsIndex, _super);

    function LocationsIndex() {
      _ref = LocationsIndex.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    LocationsIndex.prototype.template = JST['locations/index'];

    LocationsIndex.prototype.events = {
      'submit #new_location': 'createLocation',
      'click #delete': 'deleteLocation'
    };

    LocationsIndex.prototype.initialize = function() {
      this.collection.on('reset', this.render, this);
      return this.collection.on('add', this.appendLocation, this);
    };

    LocationsIndex.prototype.render = function() {
      $(this.el).html(this.template());
      this.collection.each(this.appendLocation);
      return this;
    };

    LocationsIndex.prototype.appendLocation = function(location) {
      var view;
      view = new Mapish.Views.Location({
        model: location
      });
      return $('#locations').append(view.render().el);
    };

    LocationsIndex.prototype.createLocation = function(event) {
      var attributes;
      event.preventDefault();
      $('#new_location_name').removeClass('error').addClass('line');
      $('#new_location_address').removeClass('error').addClass('line');
      $('small').remove();
      attributes = {
        name: $('#new_location_name').val(),
        address: $('#new_location_address').val()
      };
      return this.collection.create(attributes, {
        wait: true,
        success: function() {
          return $('#new_location')[0].reset();
        },
        error: this.handleError
      });
    };

    LocationsIndex.prototype.deleteLocation = function(event) {
      var id, l;
      event.preventDefault();
      id = event.currentTarget.value;
      console.log(id);
      console.log(this.collection);
      l = this.collection.findWhere({
        'id': id
      });
      return console.log(l);
    };

    LocationsIndex.prototype.handleError = function(location, response) {
      var error, errors, index, _results;
      if (response.status === 422) {
        errors = $.parseJSON(response.responseText).errors;
        _results = [];
        for (index in errors) {
          error = errors[index];
          $('#new_location_' + error.key).removeClass('line').addClass('error');
          _results.push($('#new_location_' + error.key).after('<small class="error">' + error.message + '</small>'));
        }
        return _results;
      }
    };

    return LocationsIndex;

  })(Backbone.View);

}).call(this);
