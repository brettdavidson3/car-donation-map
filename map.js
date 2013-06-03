google.maps.event.addDomListener(window, 'load', initialize);
initCarData();

function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(39.093000,-105.661000),
    zoom: 7,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map-canvas"),
    mapOptions);
  initCarData();
}

function initCarData() {
  var geocoder = new google.maps.Geocoder();
  var cars = use_count? top_by_count : top_by_perc;
  for (i in cars) {
    var car = cars[i];
    geocoder.geocode( { 'address': car.county}, onGeocodeResult);
  }
}

function onGeocodeResult(results, status) {
  if (status == google.maps.GeocoderStatus.OK) {
    var marker = new google.maps.Marker({
      map: map,
      position: results[0].geometry.location
    });
  } else {
    console.log("Geocode was not successful for the following reason: " + status);
  }
}