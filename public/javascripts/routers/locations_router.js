// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Mapish.Routers.Locations = (function(_super) {
    __extends(Locations, _super);

    function Locations() {
      _ref = Locations.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Locations.prototype.routes = {
      '': 'index',
      'locations/:id': 'show'
    };

    Locations.prototype.initialize = function() {
      this.collection = new Mapish.Collections.Locations();
      return this.collection.fetch({
        reset: true
      });
    };

    Locations.prototype.index = function() {
      var view;
      view = new Mapish.Views.LocationsIndex({
        collection: this.collection
      });
      return $('#container').html(view.render().el);
    };

    Locations.prototype.show = function(id) {
      return alert("Location " + id);
    };

    return Locations;

  })(Backbone.Router);

}).call(this);
