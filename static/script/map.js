let geocoder;
function initMap() {
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


  const minimap = new google.maps.Map(document.getElementById("minimap"), {
    zoom: 12,
    center: uluru,
    streetViewControl: false,
    mapTypeControl: false,
  });
  const marker2 = new google.maps.Marker({
    position: uluru,
    map: minimap,
  });
  marker2.setMap(null);
  geocoder = new google.maps.Geocoder();
}
function geocode(request) {
  clear();
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
