<%-- 
    Document   : registrationFailure
    Created on : 16-Mar-2014, 3:19:55 PM
    Author     : seang_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%-- 
    
THIS PAGE DISPLAYS REASON FOR REGISTRATION FAILURE

--%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Uh Oh!</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    </head>
    <body>
        <div class="jumbotron">
        <h1>Oh no!</h1>
        <p><strong> <%= session.getAttribute("fail") %> </strong> </p>
        <% session.removeAttribute("fail"); %>
        <p>Please click the button to go back to the register page!</p> 
        
        <p> We here at <strong> Kuya Hotels Inc. &reg;</strong> would love to have you!</p>
        <p>
          <a class="btn btn-lg btn-primary" href="register.jsp" role="button">Register Now!</a>
        </p>
      </div>
    </body>
</html>
