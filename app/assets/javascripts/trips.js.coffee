# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Selector for geocoding input
PLACE_INPUT = "input.place-geocode"
# Sortable list
SORTABLE = "#sortable"
# Create new place button
NEW_PLACE_BUTTON = "button#create-new-place"
# Select year field
SELECT_YEAR = "select#trip-date[name='trip[trip_date(1i)]']"
# Select month field
SELECT_MONTH = "select#trip-date[name='trip[trip_date(2i)]']"

class PlacesGrid
  constructor: () ->
    $(SORTABLE).sortable({
      placeholder: "ui-state-highlight"
    })
    $(SORTABLE).disableSelection()

  generate_li = (place, lat, lon) ->
    "<li class='ui-state-default'>" + place + " <button class='remove_place close'>&times;</button>" +
    "<input id='trip_place_name' name='trip[places][][name]' type='hidden' value='" + place + "' />" +
    "<input id='trip_place_lat' name='trip[places][][lat]' type='hidden' value='" + lat + "' />" +
    "<input id='trip_place_lon' name='trip[places][][lon]' type='hidden' value='" + lon + "' />" +
    "</li>"

  add_place: (place, lat, lon) ->
    $(SORTABLE).append(generate_li(place, lat, lon))
    $(PLACE_INPUT).val('')

  remove_place: (jquery_place) ->
    jquery_place.remove()

  show_alert: (title, content) ->
    popover = $(NEW_PLACE_BUTTON).data("popover", null).popover({
      title: title,
      content: content
    }).popover("show")

  clear_alert: () ->
    $(NEW_PLACE_BUTTON).popover("hide")

class Geocoder
  constructor: (@grid) ->
    @geocoder = new google.maps.Geocoder()

  is_a_city = (geocode_result) ->
    types = geocode_result["types"]
    types[0] != "country" && types[1] == "political"

  validate: (text) ->
    result = @geocoder.geocode({ "address": text }, ( (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        result = results[0]
        name = result["address_components"][0]["long_name"] 
        if is_a_city(result)
          lat = result["geometry"]["location"].lat()
          lon = result["geometry"]["location"].lng()
          @grid.add_place(name, lat, lon)
        else
          @grid.show_alert("Place is not a city", "It seems that " + text +
            " is not a city. Please try entering a city name.")
      else
        @grid.show_alert("Place not found", "Sorry, but we couldn't find " + text)
    ))

set_months = () ->
  current_date = new Date()
  if $(SELECT_YEAR)[0].value == current_date.getFullYear().toString()
    current_month = current_date.getMonth()
    $(SELECT_MONTH + " option:gt( " + current_month + ")").hide()
    # Reset month to last possible when selected month is in the future
    $(SELECT_MONTH).val(current_month) if $(SELECT_MONTH)[0].value > current_month + 1
  else
    $(SELECT_MONTH + " option").show()

jQuery =>
  @grid = new PlacesGrid
  @geocoder = new Geocoder(@grid)

  $(PLACE_INPUT).geocomplete()

  $(document).on("click", "button.remove_place", (e) =>
    e.preventDefault()
    @grid.remove_place($(e.target).parent())
  )

  $(NEW_PLACE_BUTTON).click =>
    if $(PLACE_INPUT).val()
      @geocoder.validate($(PLACE_INPUT).val())

  $(PLACE_INPUT).click =>
    @grid.clear_alert()

  set_months()
  $(SELECT_YEAR).change (e) ->
    set_months()
