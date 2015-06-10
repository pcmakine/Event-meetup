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

            <div class="input-group col-xs-12">
                <form:input id="newEventName" path="name" class="form-control" placeholder="Event name" required="required"/><form:errors path="name" /><br/>
            </div>
        </div>

        <div class="form-group row">

            <div class="input-group col-xs-12">
                <form:input id="newEventAddress" path="location.address" class="form-control" placeholder="Address"/><form:errors path="location.address" /> 
                <span class="input-group-btn">
                    <button onmousedown="showPlace('test', document.getElementById('newEventAddress').value)" class="btn btn-default" type="button"><i class="glyphicon glyphicon-search"></i></button>
                </span>
            </div>
        </div>


        <div class="form-group row">

            <div class="input-group col-xs-12">
                <form:input id="newEventDate" type="text" path="date" value="${fmtDate}" name="event.date" class="date-picker form-control" placeholder="Date: DD.MM.YYYY" /><br/>
                  <label for="newEventDate" class="input-group-addon btn">
                    <span class="glyphicon glyphicon-calendar"></span>
                </label>
            </div>
        </div>


        <div class="form-group row">
            <div class="input-group col-xs-12">
                <input id="newEventTime" type="datetime-local" class="form-control" placeholder="Time HH:mm"/><form:errors path="time" /><br/>

            </div>
        </div>

        <div class="form-group row">

            <div class="input-group col-xs-12">
                <form:textarea id="newEventDescription" path="description" class="form-control" rows="2" cols="30" placeholder="Description" /><form:errors path="description" /><br/>
            </div>
        </div>
        <form:input id="newEventLongitude" path="location.longitude" type="hidden"/>
        <form:input id="newEventLatitude" path="location.latitude" type="hidden"/>
        <input class="btn btn-default" value="Create event" type="submit"/>
    </form:form>
        
        <div class="form-horizontal">
                <div class="control-group">
        <label for="date-picker-2" class="control-label">B</label>

            <div class="input-group">
                <input id="date-picker-2" type="text" class="date-picker form-control" />
                <label for="date-picker-2" class="input-group-addon btn">
                    <span class="glyphicon glyphicon-calendar"></span>

                </label>
            </div>

    </div>
        </div>
</div>