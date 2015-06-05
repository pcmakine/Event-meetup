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
var geocoder;
var myCenter=new google.maps.LatLng(51.508742,-0.120850);
var mapProp = {
	center:new google.maps.LatLng(60.1733244,24.9410248), //start from helsinki
	zoom:10,
	mapTypeId:google.maps.MapTypeId.ROADMAP
};
 
  
var marker=new google.maps.Marker({
  position:myCenter,
});
var map;
function initialize() {
	geocoder = new google.maps.Geocoder();
	map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
	marker.setMap(map);
}
function geocodeAddress(placeName, address, func){
	geocoder.geocode({ 'address': address}, function(results, status){
		if(status == google.maps.GeocoderStatus.OK){
			func(placeName, address, results[0].geometry.location)
		}
	});
}
function moveMap(placeName, address, coordinates){
	if(coordinates != null){
		map.panTo(coordinates)
		var infowindow = new google.maps.InfoWindow({
			content: placeName
		});
		marker.setMap(null)
		marker = new google.maps.Marker({
			position:coordinates,
		});
		marker.setMap(map);
		
		map.setZoom(15)
	   
		google.maps.event.addListener(marker, 'click', function() {
			infowindow.open(map,marker);
		});
		return false;
	}
}
function showPlace(placeName, address){
	geocodeAddress(placeName, address, moveMap);
}
google.maps.event.addDomListener(window, 'load', initialize);
marker.setMap(map);


