<%-- 
    Document   : registrationSuccess
    Created on : 16-Mar-2014, 3:04:27 PM
    Author     : seang_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Complete!</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    </head>
    <body>
        <div class="jumbotron">
        <h1>Congratulations! <%= session.getAttribute("first") %> <%= session.getAttribute("last") %></h1>
        <% session.removeAttribute("first"); session.removeAttribute("last"); %>
        <p>You can now user your e-mail address to sign in to <strong> Kuya Hotels Inc. &reg;</strong>.</p>
        <p>
          <a class="btn btn-lg btn-primary" href="index.jsp" role="button">Sign In page</a>
        </p>
      </div>
    </body>
</html>
