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
    </head>
    <body>
        <%@include file="includes/navigation.jsp" %>
        <h1>Events</h1>

        <div id="googleMap"  style="width:100%;height:380px;"></div>
        <ul>
            <c:forEach var="event" items="${events}">
                <li>
                    <a href="/events/${event.id}">${event.name}, ${event.location.address}</a>
                </li>
            </c:forEach>
        </ul>
        <a href="/events/createform">Create a new event</a>
    </body>
</html>
