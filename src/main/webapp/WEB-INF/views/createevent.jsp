<%-- 
    Document   : createevent
    Created on : May 30, 2015, 1:59:06 AM
    Author     : Pete
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="includes/navigation.jsp" %>
        <div>
            <form:form commandName="event" action="/events" method="POST" >
                Name: <form:input path="name" /> <form:errors path="name" /><br/>
                Address: <form:input path="location.address" /> <form:errors path="location.address" /><br/>
                Description: <form:textarea path="description" rows="5" cols="30"/> <form:errors path="description" /><br/>
                <input type="submit"/>
            </form:form>
        </div>
    </body>
</html>
