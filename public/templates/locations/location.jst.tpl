<input id="ac-<%= location.id %>" name="accordion" type="radio"/>
<label for="ac-<%= location.id %>">
  <form>
    <div class="row collapse">
      <div class="small-10 columns">
        <div class="row">
          <div class="small-6 columns">
            <input type="text" name='name' value="<%= location.name %>" placeholder="Name" class="line">
          </div>
          <div class="small-6 columns">
            <input type="text" name='address' value="<%= location.address %>" placeholder="Address" class="line">
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
      <img src="http://maps.googleapis.com/maps/api/staticmap?center=<%= location.latitude %>,<%= location.longitude %>&zoom=13&size=600x300&maptype=roadmap&markers=<%= location.latitude %>,<%= location.longitude %>&sensor=false" alt="">
    </div>
  </div>
</div>