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
                ​

            });

        </script>


    </head>
    <body>
        <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
        <jsp:useBean id="man" class="database.manager.RoomManager" scope="session" />
        <%Room rm = null;
            DecimalFormat df = new DecimalFormat("#.00");%>

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
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <nav class="navbar navbar-default" role="navigation">
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
                                                <% if (admin) {%>
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
                                        Anim pariatur cliche...
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
                        <!-- end of view rooms -->
                        <!--start of edit rooms -->
                        <div class="img-rounded roundedArea"> 
                            <a name="editRoom"></a>
                            <h1> Edit Room</h1>                           
                            <p></p>
                            <h2> Search by: </h2>
                            <%= man.makeEditSearchForm()%>
                            <%
                                if (request.getParameter("idSearch") != null) {
                                    try {
                                        rm = man.getSpecificRoomByID(Integer.parseInt(request.getParameter("roomid")));

                                        search = true;
                                        if (rm.getType() != null) {
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
                                if(request.getParameter("editEdit") != null){
                                    man.editRoom(request.getParameter("editRoomType"), Float.parseFloat(request.getParameter("editRoomPrice")), request.getParameter("editRoomDescription"),Integer.parseInt(session.getAttribute("id").toString()));
                                }
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
                            <%= man.makeAddRoomForm()%>
                            <% if (request.getParameter("addRoom") != null) {
                                    try {
                                        man.addNewRoom(request.getParameter("addRoomType"), Float.parseFloat(request.getParameter("addRoomPrice")), request.getParameter("addRoomDescription"));
                                    } catch (NumberFormatException e) {%>
                            <%= e.getMessage()%>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <!-- end of add room -->
                    </div>   
                    <!-- end of right column rooms -->
                </div>
            </div>
        </div> <!-- end of container -->
    </body>
</html>
