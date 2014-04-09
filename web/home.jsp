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
         <jsp:setProperty name="p" property="admin"  value="<%= session.getAttribute("admin")%>"/>
        <%
        } else { %>
        <jsp:setProperty name="p" property="email"     value="GUEST" />
        <jsp:setProperty name="p" property="firstName" value="GUEST"/>
        <jsp:setProperty name="p" property="lastName"  value="GUEST"/>
        <jsp:setProperty name="p" property="admin"  value="GUEST"/>
        <%
            }
        %>
        <% boolean guest = false; boolean admin = false;%>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }
        
            if(p.getAdmin().equals("Y")){
                admin = true;
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
                                <li>
                                    <a href="map.jsp">Map</a>
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
                                                <button type="submit" class="btn btn-default" id="sign" name="sign">
                                                    <% if (guest) {%>
                                                    <%= "Sign in"%>
                                                    <%
                                                    } else {%>
                                                    <%= "Sign out"%>
                                                    <%
                                                        }
                                                    %>
                                                </button>
                                                <% if (admin){%>
                                                    <%= "<button type=\"submit\" class=\"btn btn-default\" id=\"sign\" name=\"goadmin\"> Admin Page </button>"%>
                                                <%
                                                }
                                                %>
                                            </form>
                                        </li>

                                    </ul>
                                    </ul>
                                    </div>
                                                            
                                    </nav>
                                    </div>
                                    </div>
                                    <!-- NAVIGATION END -->


                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                            <div class="panel-group" id="panel-47844">
                                               
                                                <h1> View any of our spectacular rooms we offer!<%= "<a href=\"map.jsp\" class=\"btn btn-info btn-xs pull-right\">Find us!</a>" %></h1> 
                                                
                                                <% RoomDisplayManager rm = new RoomDisplayManager();
                                                        rm.openPool();
                                                    int i = 0;
                                                    for (Room room : rm.getAllTheRooms()) {%>
                                                <%= "<div class=\"panel panel-default\">"%>
                                                <%= "<div class=\"panel-heading\">"%>
                                                <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-47844" href="#panel-element-<%=i%>">Room Type: <%= room.getType()%></a>
                                                <%= "</div>"%>
                                                <%= "<div id=\"panel-element-"%><%= i + "\""%><%= " class=\"panel-collapse collapse\">"%>
                                                <%= "<div class=\"panel-body\">"%>
                                                <%= "<strong>Description:</strong> " + room.getDescription() + "<br><br><strong>Price:</strong> $" + df.format(room.getPrice()) + " per night"%> 
                                                <%= "<a href=\"bookings.jsp\" class=\"btn btn-info btn-xs pull-right\">Search Availability</a>" %>
                                                <%= "</div>"%>
                                                <%= "</div>"%>
                                                <%= "</div>"%>
                                                <%i++;
                                                    }%>

                                            </div>
                                        </div>
                                    </div>
                                    <!--end of list-->
                                     
                                    <!-- descriptive services start -->
                                    <div class="row clearfix" align="center">
		<div class="col-md-6 column">
			<h3>
				Facilities:
			</h3>
			<ul>
				<li>
					Kuya Golf Course is the perfect balance of challenge and beauty. Eighteen performance inspiring holes embraced by countless awe inspiring scenic views.
				</li>
				<li>
					Fully equipped gymnasium for people who believe in good health.
				</li>
				<li>
					24 Hour Pool Area Access
				</li>
				<li>
					Kuya Restaurant and Bar serving breakfast, lunch, and dinner.
				</li>
				<li>
					Modern arcade to keep any child busy.
				</li>
				
			</ul>
		</div>
		<div class="col-md-6 column">
			<h3>
				Services:
			</h3>
			<ul>
				<li>
					Shuttle service to and from golf course.
				</li>
				<li>
					Personal trainer to help you achieve your goals.
				</li>
				<li>
					Swimming lessons
				</li>
				<li>
					Culinary lessons
				</li>
				<li>
					Wifi Network throughout the hotel
				</li>
				
			</ul>
		</div>
	</div>
                                    
                                    <!-- descriptive services end -->
                                    </div><!-- end of container -->
                                    </body>
                                    </html>
