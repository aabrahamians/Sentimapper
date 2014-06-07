# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder

  
  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute("class", 'infobox') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-140, 0)
    boxStyle:
      width: "500px"
      
mapStyle = [
  {
    featureType: "water"
    stylers: [
      {
        color: "#46bcec"
      }
      {
        visibility: "on"
      }
    ]
  }
  {
    featureType: "landscape"
    stylers: [color: "#f2f2f2"]
  }
  {
    featureType: "road"
    stylers: [
      {
        saturation: -100
      }
      {
        lightness: 45
      }
    ]
  }
  {
    featureType: "road.highway"
    stylers: [visibility: "simplified"]
  }
  {
    featureType: "road.arterial"
    elementType: "labels.icon"
    stylers: [visibility: "off"]
  }
  {
    featureType: "administrative"
    elementType: "labels.text.fill"
    stylers: [color: "#444444"]
  }
  {
    featureType: "transit"
    stylers: [visibility: "off"]
  }
  {
    featureType: "poi"
    stylers: [visibility: "off"]
  }
]

@buildMap = (markers) ->
  handler = undefined
  handler = Gmaps.build("Google",
    builders:
      Marker: RichMarkerBuilder
  )
  handler.buildMap
    provider:
      zoom: 10
      provider_key: "AIzaSyDJJPOQH24cT6ETa9IZacS7NENpUt2MKzA"
      styles: mapStyle
      mapTypeControl: true
      panControl: false
      zoomControl: true
      streetViewControl: false
      zoomControlOptions:
        style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
        position: google.maps.ControlPosition.BOTTOM_LEFT
    internal:
      id: "map"
  , ->
    marker = handler.addMarker(
      lat: 33.923148
      lng: -118.211514
    ,
      visible: false
    )
    handler.map.centerOn marker
    markers = handler.addMarkers(markers)
    handler.bounds.extendWith markers
    handler.fitMapToBounds()