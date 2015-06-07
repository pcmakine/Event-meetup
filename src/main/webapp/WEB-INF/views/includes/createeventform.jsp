<%-- 
    Document   : createeventform
    Created on : Jun 7, 2015, 7:52:20 PM
    Author     : Pete
--%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<form:form id="eventForm" commandName="event" action="/events" method="POST" accept-charset="UTF-8" >
    Event name: <form:input id="newEventName" path="name" /> <form:errors path="name" /><br/><form:errors path="name" /> 
    Address: <form:input id="newEventAddress" path="location.address" /> <form:errors path="location.address" /> 
    <input name="searchAddress" onclick="showPlace('test', document.getElementById('newEventAddress').value)" type="button" value="Search" /><br/>
    <fmt:formatDate var="fmtDate" value="${eventForm.event.date}" pattern="dd.MM.yyyy"/>
    Date: <form:input id="newEventDate" path="date" name="event.date" value="${fmtDate}" class= "date" placeholder="dd.mm.yyyy" /><br/>
    Time: <form:input id="newEventTime" path="time" /><br/>
    Description: <form:textarea path="description" rows="5" cols="30"/> <form:errors path="description" /><br/>
    <form:input id="newEventLongitude" path="location.longitude" type="hidden"/>
    <form:input id="newEventLatitude" path="location.latitude" type="hidden"/>
    <!--                bootstrap used here for the button-->
    <input class="btn btn-default" value="Create event" type="submit"/>
</form:form>