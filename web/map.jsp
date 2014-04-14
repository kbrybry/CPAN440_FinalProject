<%-- 
    Document   : map
    Created on : 7-Apr-2014, 9:44:51 PM
    Author     : seang_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%-- 
    
    THIS PAGE DISPLAYS THE LOCATION OF THE HOTEL

--%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact us!</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link href="customCSS/style.css" rel="stylesheet">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
        <!-- SCRIPT THAT LOADS GOOGLE MAP WITH CO ORDINATES OF HOTEL -->
        <script>
      function initialize() {
        var map_canvas = document.getElementById('map_canvas');
        var map_options = {
          center: new google.maps.LatLng(43.7294, -79.6092),
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        var map = new google.maps.Map(map_canvas, map_options)
      }
      google.maps.event.addDomListener(window, 'load', initialize);
    </script>

    </head>
    <body>
        <!-- USES THE BEAN FROM HOME.JSP AND INITIALIZES BOOLEAN CONDITIONS USED TO DYNAMICALLY CHANGE CONTENT IN THE NAVIGATION BAR-->
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
            <%@include file="header.html" %>
        <!-- NAVIGATION END -->
                                    <!--- MAP LOADS HERE -->
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                            <div id="map_canvas" class="img-rounded"></div>

                                        </div>
                                    </div>

                                    <!-- END OF MAP -->

                                    </div><!-- end of container -->
                                    </body>
                                    </html>
