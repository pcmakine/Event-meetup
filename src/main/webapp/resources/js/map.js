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
var newEventMarker = null;

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
    var content = ""
    if (typeof event !== 'undefined') {
        content = createEventInfoWindowText(event)
    }
    console.log("adding marker")
    console.log("latit: " + latit)
    console.log("longit: " + longit)
    console.log("name: " + event.name)
    //  infowindow.setContent(contentStr);
    addInfoWindow(marker, content);
}

function addNewEventMarker(latit, longit, event) {
    var latLng = new google.maps.LatLng(latit, longit);
    if (newEventMarker !== null) {
        newEventMarker.setMap(null);
    }
    newEventMarker = new google.maps.Marker({
        position: latLng,
        map: map
    });
    newEventMarker.setIcon('http://maps.google.com/mapfiles/ms/icons/grn-pushpin.png')
    var content = createEventInfoWindowText(event)
    addInfoWindow(newEventMarker, content);
}

function createEventInfoWindowText(event) {
    var content = ""
    if (typeof event.name !== 'undefined' && event.name !== null) {
        content = '<h3 id="firstHeading class="firstHeading">' + event.name + '</h3>'
                + 'Address: ' + event.address;
    } else {
        content =  '<h3 id="firstHeading class="firstHeading">New event</h3>'
                + 'Address: ' + event.address;
    }
    return content;
}

function addInfoWindow(marker, content) {
    google.maps.event.addListener(marker, 'click', (function (marker, content, infowindow) {
        return function () {
            infowindow.setContent(content);
            infowindow.open(map, marker);
        };
    })(marker, content, infowindow));
}
function geocodeAddressAndFillNewEventAddressField(placeName, address, func) {
    console.log("geocodeAddress method called")
    geocoder.geocode({'address': address}, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            console.log("Status ok")
            document.getElementById('newEventAddress').value = address;
            document.getElementById('newEventLongitude').value = results[0].geometry.location.lng();
            document.getElementById('newEventLatitude').value = results[0].geometry.location.lat();
            func(placeName, address, results[0].geometry.location)
        }
    });
}
function moveMap(placeName, address, coordinates) {
    console.log("MoveMap called")
    console.log("geocoder: " + geocoder)
    if (coordinates != null) {
        var event = {};
        event.address = address;
        addNewEventMarker(coordinates.lat(), coordinates.lng(), event)
        map.panTo(coordinates)
        //    return false;
    }
}
function showPlace(placeName, address) {
    geocodeAddressAndFillNewEventAddressField(placeName, address, moveMap);
}

google.maps.event.addDomListener(window, 'load', initialize);


