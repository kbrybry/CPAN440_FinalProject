<%-- 
    Document   : contact
    Created on : 22-Mar-2014, 4:39:49 PM
    Author     : seang_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact us!</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link href="customCSS/style.css" rel="stylesheet">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
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

                                    <!--- START OF CONTACT INFO -->
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                            <div class="row clearfix">
                                                <div class="col-md-4 column" >
                                                    <div class="img-rounded" id="contactspeech">
                                                        <h1>Contact us!</h1>
                                                        <br>
                                                        <br>
                                                        <p>Do you have any general inquiries, concerns or requests?
                                                            <br><br>
                                                            <br>Send us a message! We will work with you to make your stay as wonderful as we can!
                                                            <br><br>
                                                            <br>If you do not hear from us within 12 hours, call us directly at 647 462 7228. Ask for <strong>Kuya</strong>.
                                                        </p>
                                                    </div>

                                                </div>
                                                <div class="col-md-8 column">
                                                    <div class="img-rounded" id="contactform">
                                                        <form class="form-horizontal" role="form" action="contact.jsp" method="POST">
                                                            <div class="form-group">
                                                                <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
                                                                <div class="col-sm-10">
                                                                    <input class="form-control" value="<% if (!guest) {%> <%= p.getEmail()%> <%}%>" name="from" type="email" placeholder="Enter e-mail address" required/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="inputPassword3" class="col-sm-2 control-label">Subject</label>
                                                                <div class="col-sm-10">
                                                                    <input class="form-control" name="subject" type="text" placeholder="Enter subject" required/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">Booking Reference</label>
                                                                <div class="col-sm-10">
                                                                    <input class="form-control" name="reference" type="text" placeholder="Optional"  />
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="inputPassword3" class="col-sm-2 control-label">Message</label>
                                                                <div class="col-sm-10">
                                                                    <textarea class="form-control" name="messageText" rows="10" cols="100" required>
                                                                    </textarea>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-sm-offset-2 col-sm-10">
                                                                    <button type="submit" class="btn btn-default" name="go">Send E-mail</button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <%
                                                        String result = "";
                                                        String to = "kuyahotels@gmail.com";
                                                        String from = request.getParameter("from");
                                                        String subject = request.getParameter("subject");
                                                        String reference = request.getParameter("reference");
                                                        String messageText = request.getParameter("messageText");

                                                        Properties props = System.getProperties();
                                                        props.put("mail.smtp.auth", "true");
                                                        props.put("mail.smtp.starttls.enable", "true");
                                                        props.put("mail.smtp.host", "smtp.gmail.com");
                                                        props.put("mail.smtp.port", "587");

                                                        Session ses = Session.getInstance(props,
                                                                new javax.mail.Authenticator() {
                                                                    protected PasswordAuthentication getPasswordAuthentication() {
                                                                        return new PasswordAuthentication("kuyahotels@gmail.com", "kuya1234");
                                                                    }
                                                                });
                                                        try {

                                                            if (from != null && subject != null && messageText != null) {
                                                                MimeMessage message = new MimeMessage(ses);
                                                                message.setFrom(new InternetAddress(from));
                                                                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                                                                message.setSubject(subject);
                                                                if (reference != null) {
                                                                    message.setText(from + "Booking reference:" + reference + "\r\n\r\n" + messageText);
                                                                } else {
                                                                    message.setText(messageText);
                                                                }
                                                                Transport.send(message);
                                                                result = "Your e-mail has been sent to us! A team of highly skilled monkeys lead by <strong>Joshua Balid</strong> will reply to you as soon as possible! If he cannot perform the task Kuya will jump in and save the day!";
                                                            }
                                                        } catch (MessagingException mex) {
                                                            mex.printStackTrace();
                                                            result = mex.getMessage();
                                                        }
                                                    %>
                                                    <div class="form-group">
                                                        <%= result%>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <!-- END OF CONTACT INFO -->

                                    </div><!-- end of container -->
                                    </body>
                                    </html>
