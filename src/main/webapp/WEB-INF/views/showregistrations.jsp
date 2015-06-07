<%-- 
    Document   : showregistrations
    Created on : May 29, 2015, 12:45:03 AM
    Author     : Pete
--%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrations</title>
        <script src="<c:url value="/resources/js/test.js" />"></script>

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
