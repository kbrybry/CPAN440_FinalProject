<%-- 
    Document   : editBookings
    Created on : 13-Apr-2014, 10:27:37 PM
    Author     : seang_000
--%>

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
    </head>
    <body>
         <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
         <!-- CREATES NEW EDIT BOOKINGS BEAN -->
         <jsp:useBean id="edit" class="database.manager.EditBookingsManager" scope="session" />
         <!-- INITIALIZES BOOLEAN CONDITIONS USED TO DYNAMICALLY CHANGE CONTENT IN THE NAVIGATION BAR-->
        <!-- DECIMAL FORMAT USED TO FORMAT PRICES -->
        <% boolean guest = false;
            boolean admin = false;%>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }

            if (p.getAdmin().equals("Y")) {
                admin = true;
            }
            
            DecimalFormat df = new DecimalFormat("#.00");
        %>
        <div class="container">
            <!--   NAVIGATION START -->
            <%@include file="header.html" %>
            <!-- NAVIGATION END -->
            <% if (guest){response.sendRedirect("register.jsp"); } %>
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
                                                 for(String item: edit.getBookingsByUser(p.getEmail())){%>
                                                     <%="<option value=\"" +item + "\">"+ item +"</option>" %>
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
                            <% if (request.getParameter("bookingsSearch")!= null){ %>
                            <%= edit.getSpecificBooking(Integer.parseInt(request.getParameter("item"))) %>
                            </div>
                            <%}%>
                            <% if (request.getParameter("editDelete")!= null){ edit.deleteBookings(Integer.parseInt(request.getParameter("editBookingsNumber"))); }%>
                </div><!-- end of column -->
	    </div>
        </div> <!-- container end -->
    </body>
</html>
