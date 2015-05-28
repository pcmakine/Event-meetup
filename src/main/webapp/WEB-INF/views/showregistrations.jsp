<%-- 
    Document   : showregistrations
    Created on : May 29, 2015, 12:45:03 AM
    Author     : Pete
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrations</title>
    </head>
    <body>
        <%@include file="includes/navigation.jsp" %>
        <h1>Registrations</h1>
        <ol>
            <c:forEach var="registration" items="${registrations}">
                <li>${registration.name}, ${registration.email}</li>
            </c:forEach>
        </ol>
    </body>
</html>
