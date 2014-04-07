<%-- 
    Document   : home
    Created on : 16-Mar-2014, 6:01:58 PM
    Author     : seang_000
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="database.manager.RoomDisplayManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.personalClasses.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kuya Hotel: Home</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link href="customCSS/style.css" rel="stylesheet">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>


        <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
        <% if (session.getAttribute("user") != null) {%>
        <jsp:setProperty name="p" property="email"     value="<%= session.getAttribute("user")%>" />
        <jsp:setProperty name="p" property="firstName" value="<%= session.getAttribute("first")%>"/>
        <jsp:setProperty name="p" property="lastName"  value="<%= session.getAttribute("last")%>"/>
        <%
        } else { %>
        <jsp:setProperty name="p" property="email"     value="GUEST" />
        <jsp:setProperty name="p" property="firstName" value="GUEST"/>
        <jsp:setProperty name="p" property="lastName"  value="GUEST"/>
        <%
            }
        %>
        <% boolean guest = false; %>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }
            DecimalFormat df = new DecimalFormat("#.00");
        %>
        <div class="container">
            <!--   NAVIGATION START -->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <nav class="navbar navbar-default" role="navigation">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#"><strong> Kuya Hotels Inc. &reg;</strong></a>
                        </div>

                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li class="active">
                                    <a href="home.jsp">Home</a>
                                </li>
                                <li >
                                    <a href="gallery.jsp">Gallery</a>
                                </li>
                                <li>
                                    <a href="bookings.jsp">Bookings</a>
                                </li>
                                <li>
                                    <a href="contact.jsp">Contact Us</a>
                                </li>
                            </ul>

                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        <% if (guest) {%>
                                        <%= p.getFirstName()%>
                                        <%
                                        } else if (!guest) {%>
                                        <%= p.getFirstName() + " " + p.getLastName()%>
                                        <%
                                            }
                                        %>
                                        <strong class="caret"></strong></a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <form class="navbar-form navbar-left" role="search" method="POST" action="redirect.html">
                                                <button type="submit" class="btn btn-default" id="sign">
                                                    <% if (guest) {%>
                                                    <%= "Sign in"%>
                                                    <%
                                                    } else {%>
                                                    <%= "Sign out"%>
                                                    <%
                                                        }
                                                    %>
                                                </button>
                                            </form>
                                        </li>

                                    </ul>
                                    </div>
                                                            
                                    </nav>
                                    </div>
                                    </div>
                                    <!-- NAVIGATION END -->
                                    
                                    <!-- Form START -->
                                    <form role="form" method="GET" action="bookings.jsp">
						<div class="form-group">
							 <label for="exampleInputEmail1">Check-in</label><input type="date" class="form-control" id="checkInDate" name="checkInDate"/>
						</div>
						<div class="form-group">
							 <label for="exampleInputPassword1">Check-out</label><input type="date" class="form-control" id="checkOutDate" name="checkOutDate"/>
						</div>
						<div class="checkbox">
							 <label><input type="checkbox" /> Check me out</label>
						</div> <button type="submit" class="btn btn-default" name="submitQuery">Submit</button>
                                    </form>
                                    <!-- Form END -->


                                    
                                   

                                    </div><!-- end of container -->
                                    </body>
                                    </html>
