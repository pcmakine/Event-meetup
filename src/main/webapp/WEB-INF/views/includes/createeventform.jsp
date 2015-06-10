<%-- 
    Document   : createeventform
    Created on : Jun 7, 2015, 7:52:20 PM
    Author     : Pete
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div id="createForm">
    <form:form role="form" id="eventForm" commandName="event" action="/events" method="POST" accept-charset="UTF-8" >
        <div class="form-group row">
            <label class="control-label col-xs-2" for="newEventName">Event name:</label>
            <div class="input-group col-xs-10">
                <form:input id="newEventName" path="name" class="form-control"/><form:errors path="name" /><br/>
            </div>
        </div>

        <div class="form-group row">
            <label class="control-label col-xs-2" for="newEventAddress">Address:</label>
            <div class="input-group col-xs-10">
                <form:input id="newEventAddress" path="location.address" class="form-control"/><form:errors path="location.address" /> 
                <span class="input-group-btn">
                    <button onclick="showPlace('test', document.getElementById('newEventAddress').value)" class="btn btn-default" type="button"><i class="glyphicon glyphicon-search"></i></button>
                </span>
            </div>
        </div>


        <div class="form-group row">
            <label class="control-label col-xs-2" for="newEventDate">Date:</label>
            <div class="input-group col-xs-10">
                <form:input id="newEventDate" path="date" value="${fmtDate}" name="event.date" class="date form-control" placeholder="dd.mm.yyyy" /><br/>
            </div>
        </div>


        <div class="form-group row">
            <label class="control-label col-xs-2" for="newEventTime">Time:</label>
            <div class="input-group col-xs-10">
                <form:input id="newEventTime" path="time" class="form-control"/><form:errors path="time" /><br/>

            </div>
        </div>

        <div class="form-group row">
            <label class="control-label col-xs-2" for="newEventTime">Description</label>
            <div class="input-group col-xs-10">
                <form:textarea id="newEventDescription" path="description" class="form-control" rows="2" cols="30"/><form:errors path="description" /><br/>
            </div>
        </div>
        <form:input id="newEventLongitude" path="location.longitude" type="hidden"/>
        <form:input id="newEventLatitude" path="location.latitude" type="hidden"/>
        <input class="btn btn-default" value="Create event" type="submit"/>
    </form:form>
</div>