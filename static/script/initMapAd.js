var geocoder;
var map;

function initMap() {
  geocoder = new google.maps.Geocoder();
}

function geocode(request) {
  geocoder
    .geocode(request)
    .then((result) => {
      const { results } = result;
      console.log(result)
      // console.log(results[0].geometry.location.lat())
      // console.log(results[0].geometry.location.lng())
      // return (results[0].geometry.location.lat(),results[0].geometry.location.lng());
      $.ajax({
        url: '/api/CreateAd',
        type: 'post',
        data: {
          "UID": USERConst,
          "title": $("#title").val(),
          "address": $("#address").val(),
          "appartment": $("#appartment").val(),
          "zipCode": $("#zipCode").val(),
          "town": $("#town").val(),
          "size": $("#size").val(),
          "description": $("#description").val(),
          "coordinate": results[0].geometry.location.lat() + "," + results[0].geometry.location.lng(),
          "AID": $("#appartment").val() + $("#address").val(),
          "price": $("#price").val()
        },
        success: (response) => {
          location.reload();
        }
      })
    })
    .catch((e) => {
      alert("Geocode was not successful for the following reason: " + e);
    });
}
