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
                $(".datepicker1").datepicker({
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
        <jsp:useBean id="rm" class="database.manager.RoomBookingManager" scope="session" />
        <jsp:useBean id="book" class="com.personalClasses.Booking" scope="session" />

        <% boolean guest = false;
            boolean admin = false;%>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }

            if (p.getAdmin().equals("Y")) {
                admin = true;
            }
            boolean success = false;
        %>
        <div class="container">
            <!--   NAVIGATION START -->
            <%@include file="header.html"%>
            <!-- NAVIGATION END -->
            <div class="row clearfix">
                <div class="col-md-12 column">

                    <h3>
                        Search rooms for Availability and Rates:
                    </h3>
                    <form role="form" method="GET" action="bookings.jsp">
                        <div class="form-group">
                            <label>Check-in</label><input type="text" class="datepicker1 form-control" name="checkInDate" required>
                        </div>
                        <div class="form-group">
                            <label >Check-out</label><input type="text" class="datepicker1 form-control" name="checkOutDate" required>
                        </div>
                        <div class="form-group">
                            <label >No. Of Guests:</label><select name="guests"> <option value="1">1</option> <option value="2">2</option>  <option value="3">3</option>  
                                <option value="4">4</option>  <option value="5">5</option> 
                            </select>
                        </div>
                        <div class="form-group">
                            <label >Requests:</label>
                            <textarea class="form-control" name="requests" rows="5" cols="100">None.</textarea>
                        </div>
                        <button type="submit" class="btn btn-default" name="submitQuery">Submit</button>
                    </form>
                    <br>
                    <%
                        if (request.getParameter("submitQuery") != null) {%>
                    <jsp:setProperty name="rm" property="dateIn"  value="<%= request.getParameter("checkInDate")%>"/>
                    <jsp:setProperty name="rm" property="dateOut"  value="<%= request.getParameter("checkOutDate")%>"/>
                    <jsp:setProperty name="rm" property="guests"  value="<%= request.getParameter("guests")%>"/>
                    <jsp:setProperty name="rm" property="requests"  value="<%= request.getParameter("requests")%>"/>

                    <%= rm.getAvailableRooms(rm.getDateIn(), rm.getDateOut())%>
                    <%
                        }
                    %>

                    <%
                        if (!guest) {
                            for (String type : rm.getAllRoomTypes()) {
                                if (request.getParameter(type) != null) {
                                    rm.makeBooking(type, rm.getDateIn(), rm.getDateOut(), Integer.parseInt(rm.getGuests()), rm.getRequests(), p.getEmail());
                                    success = true;
                                    if (success) {%>
                    <%= p.getFirstName() + " " + p.getLastName() + " you have successfully booked " + type + " from " + rm.getDateIn() + " to " + rm.getDateOut() + "!"%>
                    <%= "<br><br>Your booking number is:<strong>" + rm.getMaxBookingNumber() + "</strong>"%>
                    <%
                                } else if (!success) {%>
                    <%= "UH oh! Something went wrong. Try to book again!"%>
                    <%
                                                    }
                                                }
                                            }
                                        }
                                        if (guest) {%>
                    <%= "YOU MUST REGISTER TO BOOK A ROOM<br>"%>
                    <a href="register.jsp">Register</a>
                    <%
                        }
                    %>

                </div>
            </div>
        </div>

    </body>
</html>
