<%-- 
    Document   : gallery
    Created on : 16-Mar-2014, 6:46:03 PM
    Author     : seang_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link href="customCSS/style.css" rel="stylesheet">
	<script type="text/javascript" src="jquery/jquery.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
        <% boolean guest = false;boolean admin = false; %>
   <% if (p.getFirstName().equals("GUEST")){
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
    
    <!-- Random text part -->
    <div class="row clearfix">
		<div class="col-md-12 column">
			<h2>Browse through pictures of our wonderful hotel!</h2>
			<p>Be prepared to be mezmerized.</p>
			</div>
	</div>
    <!--                 -->
    <!--- Carousel Start -->
<div class="row clearfix" >
		<div class="col-md-12 column">
			<div class="carousel slide" id="carousel-2426" id="mycarousel">
				<ol class="carousel-indicators">
					<li class="active" data-slide-to="0" data-target="#carousel-2426"></li>
					<li data-slide-to="1" data-target="#carousel-2426"></li>
					<li data-slide-to="2" data-target="#carousel-2426"></li>
                    <li data-slide-to="3" data-target="#carousel-2426"></li>
                    <li data-slide-to="4" data-target="#carousel-2426"></li>
                    <li data-slide-to="5" data-target="#carousel-2426"></li>
                    <li data-slide-to="6" data-target="#carousel-2426"></li>
                    <li data-slide-to="7" data-target="#carousel-2426"></li>
                    <li data-slide-to="8" data-target="#carousel-2426"></li>
                    <li data-slide-to="9" data-target="#carousel-2426"></li>
				</ol>
                
				<div class="carousel-inner">
                
					<div class="item active">
						<img alt="" src="images/outside view.png">
						<div class="carousel-caption">
							<h4>Outside View</h4>
							<p>The majestic allure of the hotel's beauty</p>
						</div>
					</div>
                    
					<div class="item">
						<img alt="" src="images/pool.png">
						<div class="carousel-caption">
							<h4>Pool Area</h4>
							<p>This secluded pool area will have you in a blissful state of relaxation</p>
						</div>
					</div>
                    
					<div class="item">
						<img alt="" src="images/private cabanas.png">
						<div class="carousel-caption">
							<h4>Private Cabanas</h4>
                          <p>These private cabanas are perfect for a family excursion</p>
						</div>
					</div>
                                    
                                        <div class="item">
						<img alt="" src="images/golf course.png">
						<div class="carousel-caption">
							<h4>Golf Course</h4>
                          <p>Free access to superb 18 hole Golf Course with Shuttle Service</p>
						</div>
					</div>
                    
                    <div class="item">
						<img alt="" src="images/restaurant.png">
						<div class="carousel-caption">
							<h4>In-House Restaurant</h4>
                          <p>Dine in style in our four star <strong>Kuya Restaurant and Lounge &reg;</strong></p>
						</div>
					</div>
                    
                    <div class="item">
						<img alt="" src="images/love suitejpg.png">
						<div class="carousel-caption">
							<h4>Love Rooms</h4>
                          <p>Want to have some fun with that special someone?</p>
						</div>
					</div>
                    
                    <div class="item">
						<img alt="" src="images/suitejpg.png">
						<div class="carousel-caption">
							<h4>Suites</h4>
                          <p>Our beautifully decorated suites (Bedroom)</p>
						</div>
					</div>
                    
                    <div class="item">
						<img alt="" src="images/suite2.png">
						<div class="carousel-caption">
							<h4>Suites 2</h4>
                          <p>Our beautifully decorated suites (Common area)</p>
						</div>
					</div>
                    
                                    <div class="item">
						<img alt="" src="images/deluxeRoom.png">
						<div class="carousel-caption">
							<h4>Deluxe Room</h4>
                          <p>Stay in one of our Deluxe Rooms!</p>
						</div>
					</div>
                                    
                                    <div class="item">
						<img alt="" src="images/doubleRoom.png">
						<div class="carousel-caption">
							<h4>Double Room</h4>
                          <p>Simple yet elegant.</p>
						</div>
					</div>
				</div> <!-- end of carousel inner -->
                
          <a class="left carousel-control" href="#carousel-2426" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> 
          <a class="right carousel-control" href="#carousel-2426" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
			</div> <!-- end of my carousel -->
		</div> <!-- end of column -->
	</div> <!-- end of row -->
    
    <!-- carousel end -->
    
    
</div><!-- end of container -->
    </body>
</html>
