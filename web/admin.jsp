<%-- 
    Document   : admin
    Created on : 8-Apr-2014, 12:50:18 AM
    Author     : seang_000
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="com.personalClasses.Room"%>
<%@page import="database.manager.RoomManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link href="customCSS/style.css" rel="stylesheet">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript">

            $(document).ready(function() {

                $('#nav').affix({
                    offset: {top: $('#nav').offset().top}
                });
            });

        </script>
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
        <!-- USES THE BEAN FROM HOME.JSP AND INITIALIZES BOOLEAN CONDITIONS USED TO DYNAMICALLY CHANGE CONTENT IN THE NAVIGATION BAR-->
        <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
        <!-- USES ROOM MANAGER FROM HOME.JSP TO DISPLAY LIST OF ROOMS -->
        <jsp:useBean id="man" class="database.manager.RoomManager" scope="session" />
        <!-- INITIALIZES NEW BEAN USED TO PRODUCE REPORTS ON BOOKINGS, SALES, AND USERS -->
        <jsp:useBean id="rep" class="database.manager.ReportManager" scope="session" />
        <!-- OPENS CONNECTION POOL AND CREATES NEW FORMATTER TO DISPLAY FLOATS TO TWO DECIMAL PLACES -->
        <%Room rm = null; rep.openPool();
            DecimalFormat df = new DecimalFormat("#.00");%>
        <!-- ENSURES ONLY ADMIN ACCOUNTS CAN ACCESS THIS PAGE -->
        <% if (!p.getAdmin().equals("Y")) {
                response.sendRedirect("home.jsp");
            }%>
        <% boolean guest = false;
            boolean admin = false;
            boolean search = false;%>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }

            if (p.getAdmin().equals("Y")) {
                admin = true;
            }

        %>
        <div class="container">
            <a name="viewRoom"></a>
            <!--   NAVIGATION START -->
            <%@include file="header.html" %>
            <!-- NAVIGATION END -->  






            <div class="row clearfix">
                <div class="col-md-2 column img-rounded">
                    <div class="nav nav-tabs nav-stacked affix" data-spy="affix" >
                        <div class="panel-group" id="panel-113479">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a class="panel-title" data-toggle="collapse" data-parent="#panel-113479" href="#panel-element-700923">Room Manager</a>
                                </div>
                                <div id="panel-element-700923" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <a class="myItems" href="#viewRoom">View Rooms</a> <br> 
                                        <a class="myItems" href="#editRoom">Delete/Edit Room</a><br> 
                                        <a class="myItems" href="#addRoom">Add Room</a><br> 
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <a class="panel-title" data-toggle="collapse" data-parent="#panel-113479" href="#panel-element-909920">Report Generation</a>
                                </div>
                                <div id="panel-element-909920" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <a class="myItems" href="#roomReport">Room Bookings Reports</a> <br> 
                                        <ul>
                                            <li><a class="myItems" href="#roomDateSearch">View By Date</a></li>
                                            <li><a class="myItems" href="#roomDateFloorSearch">View By Date And Floor</a></li>
                                        </ul>
                                        <a class="myItems" href="#salesReport">Sales Reports</a><br>
                                        <ul>
                                            <li><a class="myItems" href="#salesDateSearch">View By Date</a></li>
                                            <li><a class="myItems" href="#salesDateAndPersonSearch">View By Person</a></li>
                                        </ul>
                                        
                                        <a class="myItems" href="#userReport">User Reports</a><br>
                                        <ul>
                                            <li><a class="myItems" href="#userView">View Users</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <ul class="nav nav-tabs nav-stacked affix" data-spy="affix">



                    </ul>
                </div>
                <div class="col-md-10 column" id="adminNav">               
                    <!-- right column-->
                    <div class="col-md-12 column">
                        <a class="myItems" href="admin.jsp">Refresh</a><br><br>
                        <!-- start of view rooms -->
                        <div class="img-rounded roundedArea"> 
                            <h2> View Rooms </h2>
                          <!-- DISPLAYS A LIST OF ALL ROOMS IN THE DATABASE -->
                        <%
                            int i = 0;
                            for (Room room : man.getAllTheRooms()) {%>
                        <%= "<div class=\"panel panel-default\">"%>
                        <%= "<div class=\"panel-heading\">"%>
                        <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-47844" href="#panel-element-<%=i%>">Room Type: <%= room.getType()%></a>
                        <%= "</div>"%>
                        <%= "<div id=\"panel-element-"%><%= i + "\""%><%= " class=\"panel-collapse collapse\">"%>
                        <%= "<div class=\"panel-body\">"%>
                        <%= "<strong>Room ID:</strong> " + room.getId() + " <br><br><strong>Description:</strong> " + room.getDescription() + "<br><br><strong>Price:</strong> $" + df.format(room.getPrice()) + " per night"%> 
                        <%= "</div>"%>
                        <%= "</div>"%>
                        <%= "</div>"%>
                        <%i++;
                            }%>
                        </div>
                        <!-- end of view rooms -->
                        <!--start of edit rooms -->
                        <br>
                        <div class="img-rounded roundedArea"> 
                            <a name="editRoom"></a>
                            <h1> Edit Room</h1>                           
                            <p></p>
                            <h2> Search by: </h2>
                            <!-- CREATES THE FORM THAT WILL ALLOW THE SEARCHING OF ROOMS -->
                            <%= man.makeEditSearchForm()%>
                            <%
                            
                                if (request.getParameter("idSearch") != null) {
                                    try {
                                        //USES ROOM ID TO LOCATE DETAILS OF A SPECIFIC ROOM
                                        rm = man.getSpecificRoomByID(Integer.parseInt(request.getParameter("roomid")));
                                        
                                        search = true;
                                        if (rm.getType() != null) {
                             // CREATES THE FORM THAT WILL ALLOW THE EDITING OF ROOMS -->
                                            session.setAttribute("id", Integer.parseInt(request.getParameter("roomid")));%>
                            <%= man.makeEditRoomForm(rm.getType(), rm.getPrice(), rm.getDescription())%>
                            <%
                            } else if (search) {%>
                            <%= "<p align=\"center\">Sorry! No results!</p>"%> 
                            <% }
                                    } catch (NumberFormatException e) {
                                    }
                                }
                            %>
                            <%
                                //USES VALUES IN EDIT FORM TO APPROPRIATELY CHANGE THE VALUES OF THE SELECTED ROOM IN THE DATABASE
                                if(request.getParameter("editEdit") != null){
                                    man.editRoom(request.getParameter("editRoomType"), Float.parseFloat(request.getParameter("editRoomPrice")), request.getParameter("editRoomDescription"),Integer.parseInt(session.getAttribute("id").toString()));
                                }
                                //DELETES SELECTED ROOM
                                if (request.getParameter("editDelete") != null) {
                                    try {
                                        man.deleteRoom(Integer.parseInt(session.getAttribute("id").toString()));

                                    } catch (NumberFormatException e) {%> <%= "<p align=\"CENTER\">ROOM ID WAS NOT FOUND! ROOM NOT DELETED</p>"%> <%}
                                       }
                            %>
                        </div>
                        <!-- end of edit rooms -->
                        <br>
                        <br>
                        <!-- start of add room -->
                        <div class="img-rounded roundedArea">                          
                            <h1>Add New Room</h1>
                            <a name="addRoom"></a>
                            <!-- CREATES THE FOR USED TO ADD NEW ROOMS TO THE BASE -->
                            <%= man.makeAddRoomForm()%>
                            <% if (request.getParameter("addRoom") != null) {
                                    try {
                                    //USES VALUES FROM FORM TO ADD NEW ROOM TO THE DATABASE
                                        man.addNewRoom(request.getParameter("addRoomType"), Float.parseFloat(request.getParameter("addRoomPrice")), request.getParameter("addRoomDescription"));
                                    } catch (NumberFormatException e) {%>
                            <%= e.getMessage()%>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <!-- end of add room -->
                        
                        <!-- start of reports-->
                        <h1>Report Generation Section</h1>
                        <h2>Room Bookings Reports</h2>
                         <a name="roomReport"></a>
                        <!-- start of room reports -->
                        <!-- start of date search report -->
                        <div class="img-rounded roundedArea">
                            <h3>Search by Date:</h3>
                            <a name="roomDateSearch"></a>
                            <%= rep.makeRoomDateSearch() %>
                            <% if(request.getParameter("roomDateSearch")!= null){ %>
                              <%= rep.getRoomDateSearch(request.getParameter("roomDateStart"),request.getParameter("roomDateEnd")) %>
                            
                            <%
                            }
                            %>
                        </div>
                        <p></p>
                        <!-- end of date search report -->
                        <!--start of date and floor search report -->
                        <div class="img-rounded roundedArea">
                            <h3>Search by Date and Floor:</h3>
                            <a name="roomDateFloorSearch"></a>
                            <%= rep.makeRoomDateAndFloorSearch() %>
                            <% if(request.getParameter("roomDateAndFloorSearch")!= null){ try{%>
                            <%= rep.getRoomDateAndFloorSearch(request.getParameter("roomDateAndFloorStart"),request.getParameter("roomDateAndFloorEnd"),Integer.parseInt(request.getParameter("roomDateAndFloorFloor"))) %>
                            
                            <%
                            }
                            catch(NumberFormatException e){%>
                              <%= "<p align=\"CENTER\">YOU MUST ENTER A FLOOR NUMBER AS A NUMBER</p>" %>
                            <%
                            }
                            }
                            %>
                        </div>
                        
                        <!-- end of date and floor search report -->
                        <!-- end of room reports -->
                        <!-- start of sales reports -->
                        <h2>Sales Reports</h2>
                         <a name="salesReport"></a>
                         <div class="img-rounded roundedArea">
                             <h3> Sales Date Search: </h3>
                            <a name="salesDateSearch"></a>
                            <%= rep.makeSalesDateSearch() %>
                            
                            <% if(request.getParameter("salesDateSearch")!= null){ %>
                              <%= rep.getSalesDateReport(request.getParameter("salesDateStart"),request.getParameter("salesDateEnd")) %>
                            
                            <%
                            }
                            %>
                         </div>
                         <br>
                         <div class="img-rounded roundedArea">
                             <h3> Search by Person and Date: </h3>
                            <a name="salesDateAndPersonSearch"></a>
                            <%= rep.makeSalesDateAndPersonSearch() %>
                            
                            <% if(request.getParameter("salesDateAndPersonSearch")!= null){ %>
                            <%= rep.getSalesDateAndPersonReport(request.getParameter("salesDateAndPersonStart"), request.getParameter("salesDateAndPersonEnd"), request.getParameter("item")) %>
                            
                            <%
                            }
                            %>
                         </div>
                         <!-- end of sales reports -->
                         
                         <br>
                         <!-- USER REPORTS -->
                         <div class="img-rounded roundedArea">
                             <h3> View Users </h3>
                            <a name="userView"></a>
                            <%= rep.listAllUsers() %>
                         </div>
                         <!-- END OF USER REPORTS -->
                        <!-- end of reports -->
                    </div>   
                    <!-- end of right column rooms -->
                </div>
            </div>
        </div> <!-- end of container -->
    </body>
</html>
