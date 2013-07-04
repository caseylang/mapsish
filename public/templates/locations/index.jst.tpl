<% _.each(locations, function(l) { %>
  <div>
    <input id="ac-<%= l.id %>" name="accordion" type="radio"/>
    <label for="ac-<%= l.id %>">
      <form>
        <div class="row collapse">
          <div class="small-10 columns">
            <div class="row">
              <div class="small-6 columns">
                <input type="text" name='name' value="<%= l.name %>" placeholder="Name" class="line">
              </div>
              <div class="small-6 columns">
                <input type="text" name='address' value="<%= l.address %>" placeholder="Address" class="line">
              </div>
            </div>
          </div>
          <div class="small-2 columns">
            <a href="#" class="icon button small alert"><i class="icon-trash"></i></a>
          </div>
        </div>
      </form>
    </label>
    <div class="map">
      <div class="row">
        <div class="small-10 small-centered columns">
          <img src="http://maps.googleapis.com/maps/api/staticmap?center=<%= l.latitude %>,<%= l.longitude %>&zoom=13&size=600x300&maptype=roadmap&markers=<%= l.latitude %>,<%= l.longitude %>&sensor=false" alt="">
        </div>
      </div>
    </div>
  </div>
<% }); %>
  <div>
    <input id="ac-new" name="accordion" type="radio" />
    <label for="ac-new">
      <form id='new_location'>
        <div class="row collapse">
          <div class="small-10 columns">
            <div class="row">
              <div class="small-6 columns">
                <input type="text" name='name' id='new_location_name' placeholder="Name" class="line">
              </div>
              <div class="small-6 columns">
                <input type="text" name='address' id='new_location_address' placeholder="Address" class="line">
              </div>
            </div>
          </div>
          <div class="small-2 columns">
            <button type="submit" class="icon button small success"><i class="icon-plus"></i></button>
          </div>
        </div>
      </form>
    </label>
  </div>