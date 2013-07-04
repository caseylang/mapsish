// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Mapish.Collections.Locations = (function(_super) {
    __extends(Locations, _super);

    function Locations() {
      _ref = Locations.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Locations.prototype.url = '/api/locations';

    Locations.prototype.model = Mapish.Models.Location;

    Locations.prototype.parse = function(response) {
      return response.locations;
    };

    return Locations;

  })(Backbone.Collection);

}).call(this);
