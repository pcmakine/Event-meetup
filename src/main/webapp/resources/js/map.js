/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var satellites = {
    "otaniemi": "otaniemi helsinki",
    "haagahelia": "vaasankatu 10 Helsinki",
    "hima": "maakaari 1 a 00790 Helsinki"
};
var infowindow = new google.maps.InfoWindow();
var geocoder;
var myCenter = new google.maps.LatLng(51.508742, -0.120850);
var mapProp = {
    center: new google.maps.LatLng(60.1733244, 24.9410248), //start from helsinki
    zoom: 10,
    mapTypeId: google.maps.MapTypeId.ROADMAP
};
var markers = [];

var map;
function initialize() {
    geocoder = new google.maps.Geocoder();
    map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

    for (index = 0; index < eventList.length; ++index) {
        addMarker(eventList[index].latitude, eventList[index].longitude, eventList[index]);
    }
}

function addMarker(latit, longit, event) {
    var latLng = new google.maps.LatLng(latit, longit);
    marker = new google.maps.Marker({
        position: latLng,
        map: map
    });
    markers.push(marker)
    if (typeof event !== 'undefined') {
        var content = '<h1 id="firstHeading"' + event.id + '" class="firstHeading">' + event.name + '</h1>'
                + 'Address: ' + event.address;
    } else {
        content = '<h1 id="firstHeading class="firstHeading">New Event</h1>'
    }
    console.log("adding marker")
    console.log("latit: " + latit)
    console.log("longit: " + longit)
    //  infowindow.setContent(contentStr);
    addInfoWindow(marker, content);
}

function addInfoWindow(marker, content) {
    google.maps.event.addListener(marker, 'click', (function (marker, content, infowindow) {
        return function () {
            infowindow.setContent(content);
            infowindow.open(map, marker);
        };
    })(marker, content, infowindow));
}
function geocodeAddress(placeName, address, func) {
    console.log("geocodeAddress method called")
    geocoder.geocode({'address': address}, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            console.log("Status ok")
            func(placeName, address, results[0].geometry.location)
        }
    });
}
function moveMap(placeName, address, coordinates) {
    console.log("MoveMap called")
    console.log("geocoder: " + geocoder)
    if (coordinates != null) {
        addMarker(coordinates.lat(), coordinates.lng())
        map.panTo(coordinates)
    //    return false;
    }
}
function showPlace(placeName, address) {
    geocodeAddress(placeName, address, moveMap);
}

google.maps.event.addDomListener(window, 'load', initialize);


