var geocoder;
var map;

function initMap() {

  geocoder = new google.maps.Geocoder();
  // The location of Uluru
  const uluru = { lat: 45.5016889, lng: -73.567256 };
  // The map, centered at Uluru
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 12,
    center: uluru,
    streetViewControl: false,
    mapTypeControl: false,
  });
  const marker = new google.maps.Marker({
    position: uluru,
    map: map,
  });
  marker.setMap(null);
  
}
function geocode(request) {
  geocoder
    .geocode(request)
    .then((result) => {
      const { results } = result;
      console.log(results)
      return results;
    })
    .catch((e) => {
      alert("Geocode was not successful for the following reason: " + e);
    });
}
