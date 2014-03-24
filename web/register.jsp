<%-- 
    Document   : register
    Created on : 16-Mar-2014, 1:50:02 AM
    Author     : seang_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
         <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
         <link rel="stylesheet" href="customCSS/signin.css" > 
    </head>
    <body>
        <div class="container">
      <form class="form-signin" role="form" method="POST" action="confirmRegistration.html">
        <h2 class="form-signin-heading">Register instantly!</h2>
        <input type="email" class="form-control" placeholder=" Enter Email address" required autofocus name="email">
        <input type="text" class="form-control" placeholder="Enter First Name" name="first" required>
        <input type="text" class="form-control" placeholder="Enter Last Name" name="last" required>
        <input type="password" class="form-control" placeholder="Password" name="pass" required>
        <input type="password" class="form-control" placeholder="Confirm Password" name="confirm" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Register Now!</button>
        <a href="index.jsp" class="btn btn-lg btn-primary btn-block">Back</a>
        <br>
        <br>
        <br>
      </form>
      
    </div> <!-- /container -->
    </body>
</html>
