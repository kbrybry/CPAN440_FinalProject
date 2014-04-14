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
    
    //CONSTRUCTOR THAT OPENS CONNECTION POOL
    public EditBookingsManager(){
        openPool();
    }
    
    //RETURNS A LIST OF ALL BOOKINGS MADE BY A USER THATS NOT OBSOLETE
    public ArrayList<String> getBookingsByUser(String userid){
        ArrayList<String> bookings = new ArrayList();
        try{
            open();
            sql = "select bookingno from bookings where userid=? AND checkindate>SYSDATE";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,userid);
            rs = stmt.executeQuery();
            while (rs.next()) {
                bookings.add(rs.getString("bookingno"));
            }
            
        }
        catch(SQLException e){
            
        }finally {
            close();
            statementClose();
        }
        return bookings;
    }
    //RETURNS SPECIFIC BOOKING BASED ON BOOKINGNO
    
    public String getSpecificBooking(int booking){
        Booking book = new Booking();
        String type = "";
        String form = "";
        try{
            open();
            sql = "select bookingno,checkindate,checkoutdate,roomtype,requests from bookings join roomlisting using (floorid,roomid) join rooms using (typeid) where bookingno=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1,booking);
            rs = stmt.executeQuery();
            while (rs.next()) {
                book.setBookingno(rs.getInt("bookingno"));
                book.setDateIn(rs.getString("checkInDate").substring(0, 10));
                book.setDateOut(rs.getString("checkOutDate").substring(0, 10));
                book.setRequests(rs.getString("requests"));
                type = rs.getString("roomtype");
            }
            form = "<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"editBookings5.jsp\">";
            form += 
            form += "</form>";
        }
        catch(SQLException e){
            
        }finally {
            close();
            statementClose();
        }
        return form;
    }
    public void deleteBookings(int bookingno){
        
    }
}
