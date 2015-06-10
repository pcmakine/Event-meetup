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

        <!--        <link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">-->
        <link href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" rel="stylesheet" type="text/css"/>
        <link href="/resources/css/styles.css"  rel="stylesheet" >
        <!-- GOOGLE FONTS Raleway -->
      <link href='http://fonts.googleapis.com/css?family=Raleway:100,200,300' rel='stylesheet' type='text/css'>



        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->


        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script src="<c:url value="/resources/js/map.js" />"></script>
        <script src="<c:url value="/resources/js/geolocationMarker.js" />"></script>
        <script>
            var eventList = [];
            <c:forEach var="event" items="${events}" varStatus="i">
            var registrationList = [];
            console.log("event " + '${event.name}' + "registrations: " + '${event.registrations}')
                <c:forEach var="registration" items="${event.registrations}" varStatus="i">
            registrationList.push('${registration.name}')
                </c:forEach>

            e = {id: '${event.id}',
                name: '${event.name}',
                registrations: registrationList,
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

        <div id="googleMap"  style="width:100%;height:300px;"></div>

        <!--END GOOGLE MAP API -->


        <!-- END CONTAINER FORM RESPONSIVE -->
        
        
        

        <div class="container">
            
            
            
            <div class="starter-template row">
               <h2>Create an Awesome Event</h2> 
                
                <div class="col-xs-0 col-md-4"></div><!-- 
                --><div id="centerContainer" class="col-xs-12 col-md-4">
                    <div id="eventDetails" ><!-- 
                        The event details are filled here dynamically by the map.js
                        --></div>
                    <!--<p class="lead">Choose an event or make your own</p>-->


                    <%@include file="includes/createeventform.jsp" %>


                    <div id="signUpForm" style="display:none;">
                        <h2 id="signupHeading">Sign up for the event!</h2>
                        <form:form role="form" class="form-horizontal" commandName="registration" action="/registrations" method="POST" >
                           <div class="form-group row">
                                <div class="input-group col-xs-12">
<!--                               label removed here-->
                                    <form:input id="name" path="name" class="form-control col-xs-12" placeholder="Name" /> <form:errors path="name" /><br/>
                                </div>
                            </div>


                           <!--turned around-->
                            <input type="submit" class="btn btn-default"/>
                            <input id="eventId" name="eventId" type="hidden"/><br/>
                        </form:form>
                    </div>
                </div>
                <div class="col-xs-0 col-md-4"></div>
            </div>

        </div><!-- /.container -->

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

        <script src="/resources/bootstrap/js/bootstrap.min.js"></script>


        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <!--        <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>-->
    </body>
</html>

