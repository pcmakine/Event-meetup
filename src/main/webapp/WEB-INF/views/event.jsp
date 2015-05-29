<%-- 
    Document   : even
    Created on : May 30, 2015, 1:29:33 AM
    Author     : Pete
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${event.name}</title>
    </head>
    <body>
         <%@include file="includes/navigation.jsp" %>
        <h1>${event.name}, ${event.location.address}</h1>
        <h3>Description</h3>
        <p>${event.description}</p>
        
    </body>
</html>
