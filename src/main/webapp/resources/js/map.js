/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var zoomOnUserLocation = 12;
var zoomOutNoUserLocation = 3;

var signupHeading = "Sign up for the event "
var chosenEvent = {};
var infowindow = new google.maps.InfoWindow();
var openInfoWindow;
var geocoder;
var myCenter = new google.maps.LatLng(51.508742, -0.120850);
var mapProp = {
    center: new google.maps.LatLng(60.1733244, 24.9410248), //start from helsinki
    zoom: zoomOutNoUserLocation,
    mapTypeId: google.maps.MapTypeId.ROADMAP
};
var markers = [];
var newEventMarker = null;
var GeoMarker;
var map;
function initialize() {
    geocoder = new google.maps.Geocoder();
    map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
    getLocation();
    GeoMarker = new GeolocationMarker(map);
    google.maps.event.addListener(map, 'click', function (event) {
        mapZoom = map.getZoom();
        startLocation = event.latLng;
        if (typeof openInfoWindow !== 'undefined' && openInfoWindow !== null) {
            openInfoWindow.close();
        }

        // setTimeout(placeMarker, 600);
    });
    for (index = 0; index < eventList.length; ++index) {
        addMarker(eventList[index].latitude, eventList[index].longitude, eventList[index]);
    }
}

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(centerMapToUserPosition);
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
}

function centerMapToUserPosition(position) {
    var latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    map.setZoom(zoomOnUserLocation);
    map.panTo(latLng);
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
    addInfoWindow(marker, content, event);
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
    addInfoWindow(newEventMarker, content, event);
}

function createEventInfoWindowText(event) {
    var content = ""
    if (typeof event.name !== 'undefined' && event.name !== null) {
        content = '<h3 id="firstHeading class="firstHeading">' + event.name + '</h3>'
                + 'Date: ' + event.date + '</br>'
                + 'Attendees: ' + event.registrations.length;
    } else {
        content = '<h3 id="firstHeading class="firstHeading">New event</h3>'
                + 'Address: ' + event.address;
    }
    return content;
}

function addInfoWindow(marker, content, event) {
    google.maps.event.addListener(marker, 'click', (function (marker, content, infowindow) {
        return function () {
            handleMarkerClick(marker, content, event);
        };
    }
    )(marker, content, infowindow));
}

function handleMarkerClick(marker, content, event) {
    infowindow.setContent(content);
    infowindow.open(map, marker);
    console.log("called the listener, event name: " + event.name)
    console.log("registrations: " + event.registrations)
    if (typeof event.name !== 'undefined' && event.name !== null) {     //If the event has a name it is an existing event
        document.getElementById('eventId').value = event.id;
        document.getElementById('signupHeading').innerText = signupHeading + event.name;
        var detailsDiv = document.getElementById('eventDetails');
        detailsDiv.innerHTML = eventDetailsHTML(event);
        document.getElementById('centerContainer').removeChild(detailsDiv);
        var parent = document.getElementById('centerContainer');
        appendFirst(parent, detailsDiv);
        var createForm = document.getElementById('createForm');
        createForm.style.display = 'none';

    } else {
        document.getElementById('signupHeading').innerText = signupHeading;
    }
    openInfoWindow = infowindow;
}
function appendFirst(parent, childNode) {
    if (parent.firstChild)
        parent.insertBefore(childNode, parent.firstChild);
    else
        parent.appendChild(childNode);
}
;


function eventDetailsHTML(event) {
    var eventDetails = "<h2>" + event.name + "</h2>";
    if (typeof event.address !== 'undefined' && event.address !== null) {
        eventDetails += startRowDiv() + startColumnDiv(2) + "<b>Address:</b> " + endDiv() +
                startColumnDiv(10) + event.address + endDiv() + endDiv();
    }
    if (typeof event.date !== 'undefined' && event.date !== null) {
        eventDetails += startRowDiv() + startColumnDiv(2) + "<b>Date:</b> " + endDiv() +
                startColumnDiv(10) + event.date + endDiv() + endDiv();
    }
    if (typeof event.time !== 'undefined' && event.time !== null) {
        eventDetails += startRowDiv() + startColumnDiv(2) + "<b>Time:</b> " + endDiv() +
                startColumnDiv(10) + event.time + endDiv() + endDiv();
    }
    if (typeof event.description !== 'undefined' && event.description !== null) {
        eventDetails += startRowDiv() + startColumnDiv(2) + "<b>Description:</b> " + endDiv() +
                startColumnDiv(10) + event.description + endDiv() + endDiv();
    }
    return eventDetails;
}

function startColumnDiv(columns) {
    return "<div class='col-xs-" + columns + "'>";
}

function startRowDiv() {
    return "<div class='row'>";
}

function endDiv() {
    return "</div>"
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
function moveMapToNewMarker(placeName, address, coordinates) {
    if (coordinates != null) {
        var event = {};
        event.address = address;
        addNewEventMarker(coordinates.lat(), coordinates.lng(), event)
        map.panTo(coordinates)
        //    return false;
    }
}
function showPlace(placeName, address) {
    geocodeAddressAndFillNewEventAddressField(placeName, address, moveMapToNewMarker);
}

google.maps.event.addDomListener(window, 'load', initialize);


