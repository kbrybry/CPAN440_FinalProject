<%-- 
    Document   : editBookings
    Created on : 13-Apr-2014, 10:27:37 PM
    Author     : seang_000
--%>

<%@page import="com.personalClasses.Booking"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Bookings</title>
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
		$( ".datepicker" ).datepicker({
			showOn: "button",
			buttonImage: "images/calendar.gif",
			buttonImageOnly: true,
                        dateFormat: 'yy-mm-dd'
		});
	});
        </script>
    </head>
    <body>
        <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
        <!-- CREATES NEW EDIT BOOKINGS BEAN -->
        <jsp:useBean id="edit" class="database.manager.EditBookingsManager" scope="session" />
        <jsp:useBean id="book" class="com.personalClasses.Booking" scope="session" />
        <!-- INITIALIZES BOOLEAN CONDITIONS USED TO DYNAMICALLY CHANGE CONTENT IN THE NAVIGATION BAR-->
        <!-- DECIMAL FORMAT USED TO FORMAT PRICES -->
        <% boolean guest = false;
            boolean admin = false;%>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }
            boolean success = false;
            if (p.getAdmin().equals("Y")) {
                admin = true;
            }

            DecimalFormat df = new DecimalFormat("#.00");
            Booking bk;
        %>
        <div class="container">
            <!--   NAVIGATION START -->
            <%@include file="header.html" %>
            <!-- NAVIGATION END -->
            <% if (guest) {
                    response.sendRedirect("register.jsp");
                } %>
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <div class="img-rounded" id="contactform">
                        <!-- FORM USED TO RECEIVE INFORMATION TO SEND IN EMAIL -->
                        <form class="form-horizontal" role="form" action="editBookings.jsp" method="POST">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Booking Reference:</label>
                                <div class="col-sm-10">
                                    <select name="bookings">
                                        <%
                                                    for (String item : edit.getBookingsByUser(p.getEmail())) {%>
                                        <%="<option value=\"" + item + "\">" + item + "</option>"%>
                                        <%
                                            }
                                        %>
                                    </select>
                                    <input type="submit" class="btn btn-success" name="bookingsSearch" value="Search Booking" />
                                </div>
                            </div>
                        </form>
                    </div> <!-- end of form -->
                    <br>


                    <div class="img-rounded roundedArea">
                        <% if (request.getParameter("bookingsSearch") != null) {
                                bk = edit.getSpecificBooking(Integer.parseInt(request.getParameter("bookings")));
                        %>
                        <jsp:setProperty name="book" property="bookingno" value="<%= bk.getBookingno()%>"/>
                        <jsp:setProperty name="book" property="dateIn" value="<%= bk.getDateIn()%>"/>
                        <jsp:setProperty name="book" property="dateOut"  value="<%= bk.getDateOut()%>"/>
                        <jsp:setProperty name="book" property="requests"  value="<%= bk.getRequests()%>"/>
                        <jsp:setProperty name="book" property="type"  value="<%= bk.getType()%>"/>
                        <%=  edit.makeEditBookingForm(book.getBookingno(), book.getDateIn(), book.getDateOut(), book.getType(), book.getRequests())%>
                        <%}%>
                        <% if (request.getParameter("editRoom") != null){%> <%= edit.makeRoomChangeRequestForm() %> <%}%>
                        <% if (request.getParameter("changeRoom")!= null){ edit.updateNewRoom(book.getBookingno(), book.getDateIn(), book.getDateOut(), request.getParameter("newRooms")); success=true; }%>
                        <% if (success){%> <%= "<p align=\"center\">Room successfully changed!</p>" %> <%}else if(!success){%> <%= "<p align=\"center\">Sorry, no rooms available!</p>" %> <%}%>
                        <% if (request.getParameter("editDelete") != null) {%> <%= "BOOKING NUMBER" + book.getBookingno() + " SUCCESSFULLY DELETED"%> <%edit.deleteBooking(book.getBookingno()); }%>
                        <% if (request.getParameter("editDates") != null) {%> <%= edit.makeDateChangeRequestForm(book.getBookingno(), book.getDateIn(), book.getDateOut()) %> <%}%>
                        <% if (request.getParameter("changeDates")!= null){%> <%edit.updateNewDates(book.getBookingno(), request.getParameter("changeDateIn"), request.getParameter("changeDateOut"), book.getType()); %> <%}%>
                        <% if (request.getParameter("editRequest") != null) {%> <%= edit.makeChangeRequestForm(book.getBookingno(), book.getRequests())%> <%= "<p align=\"center\">Dates successfully changed!" %> <%}%>
                        <% if (request.getParameter("editChangeRequests") != null) {%> <% edit.updateRequest(request.getParameter("editRequestsFinalChanges"), book.getBookingno()); %> <%}%>
                    </div>

                </div><!-- end of column -->
            </div>
        </div> <!-- container end -->
    </body>
</html>
