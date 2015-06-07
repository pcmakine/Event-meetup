<%-- 
    Document   : test
    Created on : Jun 7, 2015, 2:51:56 PM
    Author     : Juho
--%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

        <title>Event Meetup</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">

 

        <!-- Bootstrap core CSS -->

        <link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="/resources/css/styles.css">

        <!-- Custom styles for this template -->
        <link href="starter-template.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->


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

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Event Meetup</a>
                </div>
                <!-- <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="#about">About</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </div>/.nav-collapse -->
            </div>
        </nav>

        <!--GOOGLE MAP API -->

        <div id="googleMap"  style="width:100%;height:310px;"></div>

        <!--END GOOGLE MAP API -->
        <!--TABS NAV-->
        
<ul class="nav nav-tabs">
  <li role="presentation" class="active"><a href="#">Create Event</a></li>
  <li role="presentation"><a href="#">Event Details</a></li>
  
</ul>
        
        <!--END TABS NAV-->

    <!-- END CONTAINER FORM RESPONSIVE -->

    <div class="container">

        <div class="starter-template">

            
<!--<p class="lead">Choose an event or make your own</p>-->

        <!--CONTAINER FORM RESPONSIVE -->


    <form:form id="eventForm" commandName="event" action="/events" method="POST" accept-charset="UTF-8" >
        
        
        <fmt:formatDate value="${yourObject.date}" var="dateString" pattern='dd.MM.yyyy' />
        
        Event name: <form:input id="newEventName" path="name" /> <form:errors path="name" /><br/><form:errors path="name" /> 
        
        Address: <form:input id="newEventAddress" path="location.address" /> <form:errors path="location.address" /> 
        <input name="searchAddress" onclick="showPlace('test', document.getElementById('newEventAddress').value)" type="button" class="btn btn-default" value="Search" /><br/>
        Date: <form:input id="newEventDate" path="date" class= "date" placeholder="dd.mm.yyyy" value ="<fmt:formatDate value='' pattern='dd.MM.yyyy' />"/><br/>
        Time: <form:input id="newEventTime" path="time" /><br/>
        Description: <form:textarea path="description" rows="5" cols="30"/> <form:errors path="description" /><br/>
        <form:input id="newEventLongitude" path="location.longitude" type="hidden"/>
        <form:input id="newEventLatitude" path="location.latitude" type="hidden"/>
        <!--                bootstrap used here for the button-->
        <input class="btn btn-default" value="Create event"  type="submit"/>
    </form:form>
        
<form:form id="eventForm" commandName="event" action="/events" method="POST" accept-charset="UTF-8" >
<fmt:formatDate value="${yourObject.date}" var="dateString" pattern='dd.MM.yyyy' />
<table>
    <tr>
        <td>Event name:</td>
        <td><form:input id="newEventName" path="name" /></td>
        <td> <form:errors path="name" /><br/><form:errors path="name" /> </td>
    </tr>
    <tr>
        <td>Address:</td>
        <td> <form:input id="newEventAddress" path="location.address" /></td>
        <td>  <input name="searchAddress" onclick="showPlace('test', document.getElementById('newEventAddress').value)" type="button" class="btn btn-default" value="Search" /><form:errors path="location.address" /> </td>
    </tr>
    <tr>
        <td>Date:</td>
        <td><form:input id="newEventDate" path="date" class= "date" placeholder="dd.mm.yyyy" value ="<fmt:formatDate value='' pattern='dd.MM.yyyy' />"/></td>
        <td></td>
    </tr>
    <tr>
        <td>Time:</td>
        <td><form:input id="newEventTime" path="time" /></td>
        <td></td>
    </tr>
    <tr>
        <td>Description:</td>
        <td><form:textarea path="description" rows="5" cols="30"/></td>
        <td><form:errors path="description" /></td>
    </tr>
</table>
        
</form:form>
   
        
 
        
        

    <h2 id="signupHeading">Sign up for the event!</h2>

    <div>
        <form:form commandName="registration" action="/registrations" method="POST" >
            Name: <form:input path="name" /> <form:errors path="name" /><br/>
            <form:input path="email" type="hidden"/> <form:errors path="email" /><br/>
            <input class="btn btn-default" value="Join" type="submit"/>
        </form:form>
    </div>

            
        </div>

    </div><!-- /.container -->
   

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <script src="/resources/bootstrap/js/bootstrap.min.js"></script>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

