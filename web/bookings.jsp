<%-- 
    Document   : bookings
    Created on : Mar 19, 2014, 2:17:14 PM
    Author     : deadeye
--%>

<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.personalClasses.Person"%>
<%@page import="database.manager.RoomBookingManager" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kuya Hotel: Bookings</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link href="customCSS/style.css" rel="stylesheet">
	<script type="text/javascript" src="jquery/jquery.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>
    <jsp:useBean id="p" class="com.personalClasses.Person" scope="application" />
   <% if (session.getAttribute("user") != null){ %>
    <jsp:setProperty name="p" property="email"     value="<%= session.getAttribute("user")%>" />
    <jsp:setProperty name="p" property="firstName" value="<%= session.getAttribute("first")%>"/>
    <jsp:setProperty name="p" property="lastName"  value="<%= session.getAttribute("last")%>"/>
   <%
   }
   else{ %>
    <jsp:setProperty name="p" property="email"     value="GUEST" />
    <jsp:setProperty name="p" property="firstName" value="GUEST"/>
    <jsp:setProperty name="p" property="lastName"  value="GUEST"/>
   <%
   }
   %>
   <%! boolean guest = false; %>
   <% if (p.getFirstName().equals("GUEST")){
       guest = true;
   }
   %>
        <div class="container">
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
                                                
                                                    <li><a href="bookings.jsp">Bookings</a></li>
                                                
                                                <li>
							<a href="#">Map</a>
						</li>
                                                <li>
							<a href="#">Contact Us</a>
                                                </li>
                                        </ul>
					<form class="navbar-form navbar-left" role="search">
						<div class="form-group">
							<input type="text" class="form-control" />
						</div> <button type="submit" class="btn btn-default">Submit</button>
					</form>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                                        <% if (guest){ %>
                                                         <%= p.getFirstName()  %>
                                                        <%
                                                        }else{%>
                                                         <%= p.getFirstName() + " " + p.getLastName() %>
                                                        <%
                                                        }
                                                        %>
                                                        <strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
                                                                <form class="navbar-form navbar-left" role="search" method="POST" action="redirect.html">
								 <button type="submit" class="btn btn-default" id="sign">
                                                                    <% if (guest){ %>
                                                                        <%= "Sign in" %>
                                                                        <%
                                                                        }else{%>
                                                                           <%= "Sign out" %>
                                                                            <%
                                                                            }
                                                                            %>
                                                                 </button>
								</form>
								</li>
						
					</ul>
				</div>
				
			</nav>
			<div class="row clearfix">
				<div class="col-md-12 column">
					<h3>
						Check Availability and Rates:
					</h3>
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
                                    <%
                                     RoomBookingManager rm = new RoomBookingManager();
                                     String submitButton = request.getParameter("submitQuery");
                                     String checkInDate = request.getParameter("checkInDate");
                                     ArrayList<String> rooms = new ArrayList();
                                     String checkOutDate = request.getParameter("checkOutDate");
                                     if(submitButton != null) {
                                        
                                        
                                        
                                         rooms = rm.getAvailableRooms(checkInDate, checkOutDate);
                                         
                                        
                                         for(int i = 0; i < rooms.size(); i++) {
                                         %>
                                         <table border="1">
                                             <tr>
                                                 <th>Type</th>
                                                 <th>Desc</th>
                                             </tr>
                                             <tr>
                                                 <td><%out.println(rooms.get(i));%></td>
                                                 <td></td>
                                                 <td><a href="" >Book Room</a></td>
                                             </tr>
                                             
                                         </table>
                                         <%
                                            //out.println(rooms.get(i));
                                         }
                                         //out.println(newe);
                                         
                                         //out.println(newe);
                                     }
                                    %>
				</div>
			</div>
		</div>
	</div>
</div>
    </body>
</html>
