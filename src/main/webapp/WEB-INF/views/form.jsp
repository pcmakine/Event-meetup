<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Le Dance Signup</title>
    </head>
    <body>
        <%@include file="includes/navigation.jsp" %>
        <h1>Sign up for Le Dance!</h1>

        <div>
            <form:form commandName="registration" action="/registrations" method="POST" >
                Name: <form:input path="name" /> <form:errors path="name" /><br/>
                Email: <form:input path="email" /> <form:errors path="email" /><br/>
                <input type="submit"/>
            </form:form>
        </div>
    </body>
</html>
