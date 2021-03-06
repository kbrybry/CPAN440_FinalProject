<%-- 
    Document   : contact
    Created on : 22-Mar-2014, 4:39:49 PM
    Author     : seang_000
--%>

<!--
    THIS PAGE IS USED TO SEND EMAILS TO THE HOTEL FOR QUESTIONS
-->

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
        <!-- USES THE BEAN FROM HOME.JSP AND INITIALIZES BOOLEAN CONDITIONS USED TO DYNAMICALLY CHANGE CONTENT IN THE NAVIGATION BAR-->
        <jsp:useBean id="p" class="com.personalClasses.Person" scope="session" />
        <% boolean guest = false;
            boolean admin = false;%>
        <% if (p.getFirstName().equals("GUEST")) {
                guest = true;
            }

            if (p.getAdmin().equals("Y")) {
                admin = true;
            }

        %>
        <div class="container">
            <!--   NAVIGATION START -->
            <%@include file="header.html" %>
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
                                <!-- FORM USED TO RECEIVE INFORMATION TO SEND IN EMAIL -->
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
                                        
                                        
                             <%-- 
                                    TAKES INFORMATION RECEIVED FROM FORM AND USES IT TO SEND EMAIL
                             --%>           
                            
                            <%
                                 
                                String result = "";
                                //FILLS FIELDS NEEDED TO SEND EMAIL 
                                String to = "kuyahotels@gmail.com";
                                String from = request.getParameter("from");
                                String subject = request.getParameter("subject");
                                String reference = request.getParameter("reference");
                                String messageText = request.getParameter("messageText");
                                //USES SYSTEM PROPERTIES TO SET GMAIL SMPT
                                Properties props = System.getProperties();
                                props.put("mail.smtp.auth", "true");
                                props.put("mail.smtp.starttls.enable", "true");
                                props.put("mail.smtp.host", "smtp.gmail.com");
                                props.put("mail.smtp.port", "587");
                                //SETS E-MAIL ACCOUNT USED TO HOST THE MAIL SERVICE
                                Session ses = Session.getInstance(props,
                                        new javax.mail.Authenticator() {
                                            protected PasswordAuthentication getPasswordAuthentication() {
                                                return new PasswordAuthentication("kuyahotels@gmail.com", "kuya1234");
                                            }
                                        });
                                try {
                                    //ENSURES ALL FIELDS NEEDED ARE FILLED
                                    if (from != null && subject != null && messageText != null) {
                                        //CREATES NEW EMAIL MESSAGE AND SETS PARAMETERS REQUIRED FOR SENDING EMAIL
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
