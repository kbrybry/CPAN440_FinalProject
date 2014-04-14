/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.manager;

import com.personalClasses.Booking;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author seang_000
 */
public class EditBookingsManager extends DataManager {

    String form, oldDate, newDate;

    //CONSTRUCTOR THAT OPENS CONNECTION POOL
    public EditBookingsManager() {
        openPool();
    }

    //RETURNS A LIST OF ALL BOOKINGS MADE BY A USER THATS NOT OBSOLETE
    public ArrayList<String> getBookingsByUser(String userid) {
        ArrayList<String> bookings = new ArrayList();
        try {
            open();
            sql = "select bookingno from bookings where userid=? AND checkindate>SYSDATE";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userid);
            rs = stmt.executeQuery();
            while (rs.next()) {
                bookings.add(rs.getString("bookingno"));
            }

        } catch (SQLException e) {

        } finally {
            close();
            statementClose();
        }
        return bookings;
    }

    //RETURNS ALL THE ROOM TYPES
    public ArrayList<String> getAllRoomTypes() {
        ArrayList<String> rooms = new ArrayList();
        try {
            open();
            sql = "select roomtype from rooms";
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();
            while (rs.next()) {
                rooms.add(rs.getString("roomtype"));
            }

        } catch (SQLException e) {

        } finally {
            close();
            statementClose();
        }
        return rooms;
    }
    //RETURNS SPECIFIC BOOKING BASED ON BOOKINGNO

    public Booking getSpecificBooking(int booking) {
        Booking book = new Booking();
        try {
            open();
            sql = "select bookingno,checkindate,checkoutdate,roomtype,requests from bookings join roomlisting using (floorid,roomid) join rooms using (typeid) where bookingno=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, booking);
            rs = stmt.executeQuery();
            while (rs.next()) {
                book.setBookingno(rs.getInt("bookingno"));
                book.setDateIn(rs.getString("checkInDate").substring(0, 10));
                book.setDateOut(rs.getString("checkOutDate").substring(0, 10));
                book.setRequests(rs.getString("requests"));
                book.setType(rs.getString("roomtype"));
            }
        } catch (SQLException e) {

        } finally {
            close();
            statementClose();
        }
        return book;
    }

    public void deleteBooking(int bookingno) {
        try {
            open();
            sql = "DELETE FROM BOOKINGS WHERE bookingno=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingno);
            stmt.execute();
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
    }

    public void updateRequest(String request, int bookingno) {
        try {
            open();
            sql = "UPDATE BOOKINGS SET REQUESTS=? WHERE bookingno=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, request);
            stmt.setInt(2, bookingno);
            stmt.executeUpdate();
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
    }

    public void updateNewRoom(int bookingno, String newIn, String newOut, String type) {
        ArrayList<String> floors = new ArrayList();
        boolean booked = false;
        try {
            open();
            sql = "SELECT DISTINCT floorid FROM ROOMS JOIN roomlisting USING (typeid) where roomtype=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, type);
            rs = stmt.executeQuery();
            while (rs.next()) {
                floors.add(rs.getString("floorid"));
            }
            if (!booked) {
                for (String floor : floors) {
                    if (booked) {
                        break;
                    }
                    ArrayList<String> rooms = new ArrayList();
                    stmt = conn.prepareStatement("select roomid FROM ROOMS JOIN roomlisting USING (typeid) where roomtype=? AND floorid=?");
                    stmt.setString(1, type);
                    stmt.setString(2, floor);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        rooms.add(rs.getString("roomid"));
                    }

                    if (!booked) {
                        for (String room : rooms) {
                            stmt = conn.prepareStatement("SELECT * FROM BOOKINGS JOIN roomlisting USING (floorid,roomid) WHERE checkindate BETWEEN ? AND ? AND checkoutdate BETWEEN ? AND ? AND roomid=? AND floorid=?");
                            stmt.setString(1, newIn);
                            stmt.setString(2, newOut);
                            stmt.setString(3, newIn);
                            stmt.setString(4, newOut);
                            stmt.setString(5, room);
                            stmt.setString(6, floor);
                            rs = stmt.executeQuery();
                            if (!rs.next()) {
                                stmt = conn.prepareStatement("UPDATE BOOKINGS SET CHECKINDATE=?, CHECKOUTDATE=?,FLOORID=?,ROOMID=? WHERE BOOKINGNO=?");
                                stmt.setString(1, newIn);
                                stmt.setString(2, newOut);
                                stmt.setString(3, floor);
                                stmt.setString(4, room);
                                stmt.setInt(5, bookingno);

                                stmt.executeUpdate();
                                booked = true;
                                break;
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
    }
    
    public void updateNewDates(int bookingno, String newIn, String newOut, String type) {
        ArrayList<String> floors = new ArrayList();
        boolean booked = false;
        try {
            open();
            sql = "SELECT DISTINCT floorid FROM ROOMS JOIN roomlisting USING (typeid) where roomtype=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, type);
            rs = stmt.executeQuery();
            while (rs.next()) {
                floors.add(rs.getString("floorid"));
            }
            if (!booked) {
                for (String floor : floors) {
                    if (booked) {
                        break;
                    }
                    ArrayList<String> rooms = new ArrayList();
                    stmt = conn.prepareStatement("select roomid FROM ROOMS JOIN roomlisting USING (typeid) where roomtype=? AND floorid=?");
                    stmt.setString(1, type);
                    stmt.setString(2, floor);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        rooms.add(rs.getString("roomid"));
                    }

                    if (!booked) {
                        for (String room : rooms) {
                            stmt = conn.prepareStatement("SELECT * FROM BOOKINGS JOIN roomlisting USING (floorid,roomid) WHERE checkindate BETWEEN ? AND ? AND checkoutdate BETWEEN ? AND ? AND roomid=? AND floorid=?");
                            stmt.setString(1, newIn);
                            stmt.setString(2, newOut);
                            stmt.setString(3, newIn);
                            stmt.setString(4, newOut);
                            stmt.setString(5, room);
                            stmt.setString(6, floor);
                            rs = stmt.executeQuery();
                            if (!rs.next()) {
                                stmt = conn.prepareStatement("UPDATE BOOKINGS SET CHECKINDATE=?, CHECKOUTDATE=?,FLOORID=?,ROOMID=? WHERE BOOKINGNO=?");
                                stmt.setString(1, newIn);
                                stmt.setString(2, newOut);
                                stmt.setString(3, floor);
                                stmt.setString(4, room);
                                stmt.setInt(5, bookingno);

                                stmt.executeUpdate();
                                booked = true;
                                break;
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
    }

    public String makeDateChangeRequestForm(int no, String in, String out) {
        oldDate = out;
        newDate = in;
        form = "";
        form = "<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"editBookings.jsp\">";
        form += "New Check In Date: <input type=\"text\" class=\"datepicker\" name=\"changeDateIn\" required value=\"" + in + "\"> &nbsp;&nbsp;&nbsp;";
        form += "New Check Out Date: <input type=\"text\" class=\"datepicker\" name=\"changeDateOut\" required value=\"" + out + "\"> &nbsp;&nbsp;&nbsp;";
        form += "<input type=\"submit\" class=\"btn btn-success\" name=\"changeDates\"/>";
        form += "</form>";
        return form;
    }

    public String makeRoomChangeRequestForm() {

        form = "";
        form = "<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"editBookings.jsp\">";
        form += "Select New Room:";
        form += "<select name=\"newRooms\">";
        for (String room : getAllRoomTypes()) {
            form += "<option value=\"" + room + "\">" + room + "</option>";
        }
        form += "</select>";
        form += "&nbsp;&nbsp;&nbsp;<input type=\"submit\" class=\"btn btn-success\" name=\"changeRoom\" value=\"Get a new room!\"/>";
        form += "</form>";
        return form;
    }

    public String makeChangeRequestForm(int no, String requests) {
        form = "";
        //starts form
        form = "<form class=\"form-horizontal editForm\" role=\"form\" method=\"POST\" action=\"editBookings.jsp\">";
        //creates requests label and text area
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Requests:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<textarea class=\"form-control\" name=\"editRequestsFinalChanges\" rows=\"10\" cols=\"100\" required>" + requests + "</textarea>";
        form += "</div>";
        form += "</div>";
        //creates button
        form += "<div class=\"form-group myButtonSeparator\">";
        form += "<div class=\"col-sm-offset-2 col-sm-10\">";
        form += "<button type=\"submit\" class=\"btn btn-warning\" name=\"editChangeRequests\">Change Request</button>";
        form += "</div>";
        form += "</div>";

        //ends form
        form += "</form>";
        return form;
    }

    public String makeEditBookingForm(int booking, String in, String out, String type, String requests) {
        form = "";
        //starts form
        form = "<form class=\"form-horizontal editForm\" role=\"form\" method=\"POST\" action=\"editBookings.jsp\">";
        //creates booking reference label and input box 
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Booking no:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\" type=\"text\" name=\"editBookingno\" value=\"" + booking + "\" disabled=\"disabled\"/>";
        form += "</div>";
        form += "</div>";
        //creates room type label and input box 
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Room Type:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\" type=\"text\" name=\"editRoomType\" value=\"" + type + "\" disabled=\"disabled\"/>";
        form += "</div>";
        form += "</div>";
        //creates date in label and input box
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Check In Date:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\"  type=\"text\" name=\"editDateIn\" value=\"" + in + "\" disabled=\"disabled\"/>";
        form += "</div>";
        form += "</div>";
        //creates date out label and input box
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Check Out:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\"  type=\"text\" name=\"editDateOut\" value=\"" + out + "\" disabled=\"disabled\"/>";
        form += "</div>";
        form += "</div>";
        //creates requests label and text area
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Requests:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<textarea class=\"form-control\" name=\"editRequests\" rows=\"10\" cols=\"100\" disabled=\"disabled\">" + requests + "</textarea>";
        form += "</div>";
        form += "</div>";
        //buttons for form
        form += "<div class=\"form-group myButtonSeparator\">";
        form += "<div class=\"col-sm-offset-2 col-sm-10\">";
        form += "<button type=\"submit\" class=\"btn btn-warning\" name=\"editRoom\">Change Room</button> <button type=\"submit\" class=\"btn btn-warning\" name=\"editDates\">Change Dates</button> <button type=\"submit\" class=\"btn btn-warning\" name=\"editRequest\">Change Request</button> <br><br>";
        form += "DANGER! <button type=\"submit\" class=\"btn btn-danger\" name=\"editDelete\">Delete</button> !DANGER";
        form += "</div>";
        form += "</div>";

        //ends form
        form += "</form>";
        return form;
    }
}
