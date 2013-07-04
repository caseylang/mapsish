<input id="ac-<%= location.get('id') %>" name="accordion" type="radio" checked/>
<label for="ac-<%= location.get('id')%>">
  <form>
    <div class="row collapse">
      <div class="small-10 columns">
        <div class="row">
          <div class="small-6 columns">
            <input type="text" name='name' value="<%= location.get('name') %>" placeholder="Name" class="line">
          </div>
          <div class="small-6 columns">
            <input type="text" name='address' value="<%= location.get('address') %>" placeholder="Address" class="line">
          </div>
        </div>
      </div>
      <div class="small-2 columns">
        <a class="icon button small alert delete"><i class="icon-trash"></i></a>
      </div>
    </div>
  </form>
</label>
<div class="map">
  <div class="row">
    <div class="small-10 small-centered columns">
      <img src="http://maps.googleapis.com/maps/api/staticmap?center=<%= location.get('latitude') %>,<%= location.get('longitude') %>&zoom=13&size=600x300&maptype=roadmap&markers=<%= location.get('latitude') %>,<%= location.get('longitude') %>&sensor=false" alt="">
    </div>
  </div>
</div>