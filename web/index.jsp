<%-- 
    Document   : index.jsp
    Created on : 16-Mar-2014, 1:31:11 AM
    Author     : seang_000
--%>
<%-- 
    
    THIS PAGE DISPLAYS SIGNS IN REGISTERED USERS

--%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.activation.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="database.manager.UserManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log In Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="customCSS/signin.css" > 
  </head>
  <body>
    <div class="container">
        <!-- CREATES THE BEAN USED TO HANDLE THE REGISTRATION AND AUTHENTICATION OF USERS-->
       <jsp:useBean id="db" class="database.manager.UserManager" scope="session" />
       <!-- opens connection pool -->
       <% db.openPool(); %>
      <!-- FORM USED TO RECEIVE VALUES TO AUTHENTICATE USER LOG IN -->
      <form class="form-signin" role="form" method="POST" action="home.html">
        <h2 class="form-signin-heading">Please sign in</h2>
        <input type="email" class="form-control" placeholder="Email address" name="email" required autofocus>
        <input type="password" class="form-control" placeholder="Password" name="pass" required>
        <label class="checkbox">
          <input type="checkbox" value="remember-me"> Remember me
        </label>
        
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        <a href="register.jsp" class="btn btn-lg btn-primary btn-block">Register</a>
        <!-- RECEIVES MESSAGE FROM SERVLET, DISPLAYS IT, THEN REMOVES IT FROM SESSION -->
        <label class="fail">
         
            <% if (session.getAttribute("fail") != null){ %>
                <%= session.getAttribute("fail") %>
            <%
            }
            session.removeAttribute("fail");
          
            %>
        </label>
        <br>
        <br>
        <a href="home.jsp" class="btn btn-lg btn-primary btn-block">Guest Login</a>
      </form>
       
        
    </div> <!-- /container -->
  </body>
</html>
