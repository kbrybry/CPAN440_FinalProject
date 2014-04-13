<%-- 
    Document   : bookings
    Created on : Mar 19, 2014, 2:17:14 PM
    Author     : deadeye
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.personalClasses.*"%>
<%@page import="database.manager.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kuya Hotel: Bookings</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link href="customCSS/style.css" rel="stylesheet">
	<script type="text/javascript" src="jquery/jquery.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="jquery/themes/base/jquery.ui.all.css">
	<script src="jquery/jquery-1.10.2.js"></script>
	<script src="jquery/ui/jquery.ui.core.js"></script>
	<script src="jquery/ui/jquery.widget.core.js"></script>
	<script src="jquery/ui/jquery.ui.datepicker.js"></script>
        <script>
        $(function() {
		$( "#datepicker1" ).datepicker({
			showOn: "button",
			buttonImage: "images/calendar.gif",
			buttonImageOnly: true,
                        minDate: 0,
                        dateFormat: 'yy-mm-dd'
		});
	});
	</script>
    </head>
    <body>
    <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
  
   <% boolean guest = false; boolean admin = false;%>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }
        
            if(p.getAdmin().equals("Y")){
                admin = true;
            }
            
        %>
        <div class="container">
	<!--   NAVIGATION START -->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <nav class="navbar navbar-default navbar-inverse" role="navigation">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="home.jsp"><strong> Kuya Hotels Inc. &reg;</strong></a>
                        </div>

                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="home.jsp">Home</a>
                                </li>
                                <li >
                                    <a href="gallery.jsp">Gallery</a>
                                </li>
                                <li class="active">
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
                                    <form action="datepicker.jsp" method="POST">
    Date: <input type="text" id="datepicker1" name="datepicker1">
    <input type="submit" name="hi"/>
</form>
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
                                     rm.openPool();
                                     String submitButton = request.getParameter("submitQuery");
                                     String checkInDate = request.getParameter("checkInDate");
                                     //ArrayList<String> rooms = new ArrayList();
                                     String checkOutDate = request.getParameter("checkOutDate");
                                     ArrayList roomIDs = new ArrayList();
                                     ArrayList floorIDs = new ArrayList();
                                     ArrayList<Room> rooms = new ArrayList<Room>();
                                     boolean doubleRoom = false;
                                     boolean deluxeRoom = false;
                                     boolean anniversaryRoom = false;
                                     boolean privateCabanas = false;

                                     ArrayList<Room> roomsToDisplay = new ArrayList<Room>();
                                     if(submitButton != null) {
                                        rm.openPool();
                                         roomIDs = rm.getAvailableRoomIDs(checkInDate, checkOutDate);
                                        floorIDs = rm.getAvailableFloorIDs(checkInDate, checkOutDate);
                                        rooms = rm.getRoomDetails(floorIDs, roomIDs);
                                        for(int i = 0; i < rooms.size(); i++) {
                                            if(rooms.get(i).getType().equalsIgnoreCase("Double Room") && !doubleRoom) {
                                                doubleRoom = true;
                                                roomsToDisplay.add(new Room(rooms.get(i).getType(), rooms.get(i).getDescription(), rooms.get(i).getPrice()));
                                                
                                            }
                                            if(rooms.get(i).getType().equalsIgnoreCase("Deluxe Room") && !deluxeRoom) {
                                                deluxeRoom = true;
                                                roomsToDisplay.add(new Room(rooms.get(i).getType(), rooms.get(i).getDescription(), rooms.get(i).getPrice()));
                                            }
                                            if(rooms.get(i).getType().equalsIgnoreCase("Anniversary Room") && !anniversaryRoom) {
                                                anniversaryRoom = true;
                                                roomsToDisplay.add(new Room(rooms.get(i).getType(), rooms.get(i).getDescription(), rooms.get(i).getPrice()));
                                            }
                                            if(rooms.get(i).getType().equalsIgnoreCase("Private Cabanas") && !privateCabanas) {
                                                privateCabanas = true;
                                                roomsToDisplay.add(new Room(rooms.get(i).getType(), rooms.get(i).getDescription(), rooms.get(i).getPrice()));
                                            }
                                        }
                                        for(int i = 0; i < roomsToDisplay.size(); i++) {
                                         %>
                                         <table border="1">
                                             <tr>
                                                 <th>Type</th>
                                                 <th>Desc</th>
                                                 <th>Price</th>
                                             </tr>
                                             <tr>
                                                 <td>
                                                     <% out.println(roomsToDisplay.get(i).getType());
                                                     %>
                                                 </td>
                                                 <td>
                                                     <% out.println(roomsToDisplay.get(i).getDescription());
                                                     %>
                                                 </td>
                                                 <td>
                                                     <% out.println(roomsToDisplay.get(i).getPrice());
                                                     %>
                                                 </td>
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
