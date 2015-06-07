<%-- 
    Document   : showevents
    Created on : May 30, 2015, 12:11:40 AM
    Author     : Pete
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script src="<c:url value="/resources/js/map.js" />"></script>
        <script>
            var eventList = [];
            <c:forEach var="event" items="${events}">
            e = {id: '${event.id}',
                name: '${event.name}',
                description: '${event.description}',
                date: '${event.date}',
                address: '${event.location.address}',
                longitude: '${event.location.longitude}',
                latitude: '${event.location.latitude}'};
            eventList.push(e);
            </c:forEach>
        </script>
    </head>
    <body>
        <%@include file="includes/navigation.jsp" %>
        <h1>Events</h1>
        <div id="googleMap"  style="width:100%;height:380px;"></div>

        <form:form id="eventForm" commandName="event" action="/events" method="POST" accept-charset="UTF-8" >
            Event name: <form:input id="newEventName" path="name" /> <form:errors path="name" /><br/>
            Address: <form:input id="newEventAddress" path="location.address" /> <form:errors path="location.address" /> <input name="searchAddress" onclick="showPlace('test', document.getElementById('newEventAddress').value)" type="button" value="Search" /><br/>
            Date: <form:input id="newEventDate" path="date" placeholder="dd.mm.yyyy"/><br/>
            Time: <form:input id="newEventTime" path="time" /><br/>
            Description: <form:textarea path="description" rows="5" cols="30"/> <form:errors path="description" /><br/>
            <form:input id="newEventLongitude" path="location.longitude" type="hidden"/>
            <form:input id="newEventLatitude" path="location.latitude" type="hidden"/>
            <!--                bootstrap used here for the button-->
            <input class="btn btn-default" value="Create event" type="submit"/>
        </form:form>

            <h2 id="signupHeading">Sign up for the event!</h2>

        <div>
            <form:form commandName="registration" action="/registrations" method="POST" >
                Name: <form:input path="name" /> <form:errors path="name" /><br/>
                <form:input path="email" type="hidden"/> <form:errors path="email" /><br/>
                <input type="submit"/>
            </form:form>
        </div>
    </body>
</html>
