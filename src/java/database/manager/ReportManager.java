/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.manager;

import com.personalClasses.Booking;
import com.personalClasses.Person;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author seang_000
 */
public class ReportManager extends RoomManager {

    Booking book;

    public ReportManager() {
        super();
        book = new Booking();
    }

    ///////////////////FORM CREATION METHODS///////////////////////
    public String makeRoomDateSearch() {
        form = "";
        form = "<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"admin.jsp\">";
        form += "Start Date: <input type=\"text\" class=\"datepicker\" name=\"roomDateStart\" required> &nbsp;&nbsp;&nbsp;";
        form += "End Date: <input type=\"text\" class=\"datepicker\" name=\"roomDateEnd\" required> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        form += "<input type=\"submit\" class=\"btn btn-success\" name=\"roomDateSearch\" />";
        form += "</form>";
        return form;
    }

    public String makeRoomDateAndFloorSearch() {
        form = "";
        form = "<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"admin.jsp\">";
        form += "Start Date: <input type=\"text\" class=\"datepicker\" name=\"roomDateAndFloorStart\" required> &nbsp;&nbsp;&nbsp;";
        form += "End Date: <input type=\"text\" class=\"datepicker\" name=\"roomDateAndFloorEnd\" required> &nbsp;&nbsp;&nbsp;";
        form += "Floor:    <input type=\"number\" step=\"1\" name=\"roomDateAndFloorFloor\" id=\"floor\" required> &nbsp;&nbsp;&nbsp;";
        form += "<input type=\"submit\" class=\"btn btn-success\" name=\"roomDateAndFloorSearch\"/>";
        form += "</form>";
        return form;
    }

    public String makeSalesDateSearch() {
        form = "";
        form = "<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"admin.jsp\">";
        form += "Start Date: <input type=\"text\" class=\"datepicker\" name=\"salesDateStart\" required> &nbsp;&nbsp;&nbsp;";
        form += "End Date: <input type=\"text\" class=\"datepicker\" name=\"salesDateEnd\" required> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        form += "<input type=\"submit\" class=\"btn btn-success\" name=\"salesDateSearch\" />";
        form += "</form>";
        return form;
    }

    public String makeSalesDateAndPersonSearch() {
        form = "";
        form = "<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"admin.jsp\">";
        form += "<select name=\"item\">";
        for (String item : returnAllUserNames()){
            form+="<option value=\"" +item + "\">"+ item +"</option>";
        }
        form += "</select><br>";
        form += "Start Date: <input type=\"text\" class=\"datepicker\" name=\"salesDateAndPersonStart\" required> &nbsp;&nbsp;&nbsp;";
        form += "End Date: <input type=\"text\" class=\"datepicker\" name=\"salesDateAndPersonEnd\" required> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        form += "<input type=\"submit\" class=\"btn btn-success\" name=\"salesDateAndPersonSearch\" />";
        form += "</form>";
        return form;
    }
    /////////////////////QUERY METHODS///////////////////////
    
    public String listAllUsers(){
        ArrayList<Person> persons = new ArrayList();
        String results="";
        try{
            open();
            sql = "select * from users";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Person per = new Person();
                per.setEmail(rs.getString("userID"));
                per.setFirstName(rs.getString("firstname"));
                per.setLastName(rs.getString("lastname"));
                per.setAdmin(rs.getString("admin"));
                persons.add(per);
            }
        }
        catch(SQLException e){
            
        }finally {
            close();
            statementClose();
        }
        return results;
    }
    
    public ArrayList<String> returnAllUserNames(){
        ArrayList<String> names = new ArrayList();
        try{
            open();
            sql = "select userid from users";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                names.add(rs.getString("userid"));
            }
        }
        catch(SQLException e){
            
        }finally {
            close();
            statementClose();
        }
        return names;
    }
    
    public String getSalesDateAndPersonReport(String startDate, String endDate,String name) {
        ArrayList<Booking> bookings = new ArrayList();
        String results = "";
        float price;
        float total = 0;
        float allTotal = 0;
        int stay = 1;
        try {
            open();
            sql = "select * from bookings where (checkindate >=? OR checkoutdate BETWEEN ? AND ?) AND userid=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, startDate);
            stmt.setString(2,startDate);
            stmt.setString(3, endDate);
            stmt.setString(4,name);
            rs = stmt.executeQuery();
            while (rs.next()) {
                book = new Booking();
                book.setBookingno(rs.getInt("bookingno"));
                book.setDateIn(rs.getString("checkInDate").substring(0, 10));
                book.setDateOut(rs.getString("checkOutDate").substring(0, 10));
                book.setFloorid(rs.getInt("floorid"));
                book.setRoomid(rs.getInt("roomid"));
                book.setGuests(rs.getInt("guests"));
                book.setUserID(rs.getString("userID"));
                bookings.add(book);
            }

            results = name;
            results += "<table style=\"width:1000px\">";
            results += "<tr> <th>Booking Number</th> <th>User ID</th> <th>Length Of Stay</th> <th>Floor</th><th>Room</th><th>Total</th></tr>";
            for (Booking bk : bookings) {
                results += "<tr>";
                results += "<td>" + bk.getBookingno() + "</td>";
                results += "<td>" + bk.getUserID() + "</td>";
                sql = "SELECT to_date(checkoutdate,'yy-mm-dd') - to_date(checkindate,'yy-mm-dd') \"days\" from bookings WHERE bookingno=" + bk.getBookingno();
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    stay = rs.getInt("days");
                    results += "<td>" + stay + "</td>";
                }
                results += "<td>" + bk.getFloorid() + "</td>";
                results += "<td>" + bk.getRoomid() + "</td>";
                sql = "select price FROM ROOMS JOIN roomListing USING(typeid) JOIN BOOKINGS USING(floorid,roomid) where bookingno=" + bk.getBookingno();
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    price = rs.getFloat("price");
                    total = price * stay;
                    allTotal += total;
                    results += "<td>$" + df.format(total) + "</td>";
                }
                results += "</tr>";
            }
            results+="<tr><td></td><td></td><td></td><td></td>";
            results+="<td><strong>TOTAL</strong></td>";
            results+="<td><strong>$" + df.format(allTotal) + "</strong></td>";
            results += "</table>";
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
        return results;
    }
    
    public String getSalesDateReport(String startDate, String endDate) {
        ArrayList<Booking> bookings = new ArrayList();
        String results = "";
        float price;
        float total = 0;
        float allTotal = 0;
        int stay = 1;
        try {
            open();
            sql = "select * from bookings where checkindate >=? OR checkoutdate BETWEEN ? AND ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, startDate);
            stmt.setString(2,startDate);
            stmt.setString(3, endDate);
            rs = stmt.executeQuery();
            while (rs.next()) {
                book = new Booking();
                book.setBookingno(rs.getInt("bookingno"));
                book.setDateIn(rs.getString("checkInDate").substring(0, 10));
                book.setDateOut(rs.getString("checkOutDate").substring(0, 10));
                book.setFloorid(rs.getInt("floorid"));
                book.setRoomid(rs.getInt("roomid"));
                book.setGuests(rs.getInt("guests"));
                book.setUserID(rs.getString("userID"));
                bookings.add(book);
            }

            results = "<table style=\"width:1000px\">";
            results += "<tr> <th>Booking Number</th> <th>User ID</th> <th>Length Of Stay</th> <th>Floor</th><th>Room</th><th>Total</th></tr>";
            for (Booking bk : bookings) {
                results += "<tr>";
                results += "<td>" + bk.getBookingno() + "</td>";
                results += "<td>" + bk.getUserID() + "</td>";
                sql = "SELECT to_date(checkoutdate,'yy-mm-dd') - to_date(checkindate,'yy-mm-dd') \"days\" from bookings WHERE bookingno=" + bk.getBookingno();
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    stay = rs.getInt("days");
                    results += "<td>" + stay + "</td>";
                }
                results += "<td>" + bk.getFloorid() + "</td>";
                results += "<td>" + bk.getRoomid() + "</td>";
                sql = "select price FROM ROOMS JOIN roomListing USING(typeid) JOIN BOOKINGS USING(floorid,roomid) where bookingno=" + bk.getBookingno();
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    price = rs.getFloat("price");
                    total = price * stay;
                    allTotal += total;
                    results += "<td>$" + df.format(total) + "</td>";
                }
                results += "</tr>";
            }
            results+="<tr><td></td><td></td><td></td><td></td>";
            results+="<td><strong>TOTAL</strong></td>";
            results+="<td><strong>$" + df.format(allTotal) + "</strong></td>";
            results += "</table>";
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
        return results;
    }

    public String getRoomDateSearch(String startDate, String endDate) {
        ArrayList<Booking> bookings = new ArrayList();
        String results = "";
        try {
            open();
            sql = "select * from bookings where checkindate >=? OR checkoutdate BETWEEN ? AND ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, startDate);
            stmt.setString(2,startDate);
            stmt.setString(3, endDate);
            rs = stmt.executeQuery();
            while (rs.next()) {
                book = new Booking();
                book.setBookingno(rs.getInt("bookingno"));
                book.setDateIn(rs.getString("checkInDate").substring(0, 10));
                book.setDateOut(rs.getString("checkOutDate").substring(0, 10));
                book.setFloorid(rs.getInt("floorid"));
                book.setRoomid(rs.getInt("roomid"));
                book.setGuests(rs.getInt("guests"));
                book.setUserID(rs.getString("userID"));
                bookings.add(book);
            }
            results = "<table style=\"width:1000px\">";
            results += "<tr> <th>Booking Number</th> <th>User Name</th> <th>Check In Date</th><th>Check Out Date</th><th>Floor</th><th>Room</th><th>No. of Guests</th></tr>";
            for (Booking bk : bookings) {
                results += "<tr>";
                results += "<td>" + bk.getBookingno() + "</td>";
                results += "<td>" + bk.getUserID() + "</td>";
                results += "<td>" + bk.getDateIn() + "</td>";
                results += "<td>" + bk.getDateOut() + "</td>";
                results += "<td>" + bk.getFloorid() + "</td>";
                results += "<td>" + bk.getRoomid() + "</td>";
                results += "<td>" + bk.getGuests() + "</td>";
                results += "</tr>";
            }
            results += "</table>";
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
        return results;
    }

    public String getRoomDateAndFloorSearch(String startDate, String endDate, int floor) {
        ArrayList<Booking> bookings = new ArrayList();
        String results = "";
        try {
            open();
            sql = "select * from bookings where (checkindate >=? OR checkoutdate BETWEEN ? AND ?) AND FLOORID=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, startDate);
            stmt.setString(2, startDate);
            stmt.setString(3,endDate);
            stmt.setInt(4, floor);
            rs = stmt.executeQuery();
            while (rs.next()) {
                book = new Booking();
                book.setBookingno(rs.getInt("bookingno"));
                book.setDateIn(rs.getString("checkInDate").substring(0, 10));
                book.setDateOut(rs.getString("checkOutDate").substring(0, 10));
                book.setFloorid(rs.getInt("floorid"));
                book.setRoomid(rs.getInt("roomid"));
                book.setGuests(rs.getInt("guests"));
                book.setUserID(rs.getString("userID"));
                bookings.add(book);
            }
            results = "<table style=\"width:1000px\">";
            results += "<tr> <th>Booking Number</th> <th>User Name</th> <th>Check In Date</th><th>Check Out Date</th><th>Floor</th><th>Room</th><th>No. of Guests</th></tr>";
            for (Booking bk : bookings) {
                results += "<tr>";
                results += "<td>" + bk.getBookingno() + "</td>";
                results += "<td>" + bk.getUserID() + "</td>";
                results += "<td>" + bk.getDateIn() + "</td>";
                results += "<td>" + bk.getDateOut() + "</td>";
                results += "<td>" + bk.getFloorid() + "</td>";
                results += "<td>" + bk.getRoomid() + "</td>";
                results += "<td>" + bk.getGuests() + "</td>";
                results += "</tr>";
            }
            
            results += "</table>";
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
        return results;
    }
}
