/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.manager;

//import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author deadeye
 */
public class RoomBookingManager extends DataManager {

    int roomID;
    double price;
    String roomType;
    String roomDesc;
    int availability;

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getRoomDesc() {
        return roomDesc;
    }

    public void setRoomDesc(String roomDesc) {
        this.roomDesc = roomDesc;
    }

    public int getAvailability() {
        return availability;
    }

    public void setAvailability(int availability) {
        this.availability = availability;
    }

    public RoomBookingManager() {
        super();
    }

    public HashMap getAvailableRooms(String checkInDate, String checkOutDate) throws ParseException {
        HashMap rooms = new HashMap();
        try {
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date checkIn = sdf.parse(checkInDate);
            java.util.Date checkOut = sdf.parse(checkOutDate);
            /*String inDate = sdf.format(checkIn);
            String outDate = sdf.format(checkOut);
            java.util.Date moarCheckIn = sdf.parse(inDate);
            java.util.Date moarCheckOut = sdf.parse(outDate);*/
            java.sql.Date ci = new java.sql.Date(checkIn.getTime());
            java.sql.Date co = new java.sql.Date(checkOut.getTime());
            
            
                open();
                sql = "SELECT * from BOOKINGS WHERE checkindate NOT BETWEEN ? AND ? AND checkoutdate NOT BETWEEN ? AND ?";
                stmt = conn.prepareStatement(sql);
                stmt.setDate(1, ci);
                stmt.setDate(2, co);
                stmt.setDate(3, ci);
                stmt.setDate(4, co);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    rooms.put(rs.getString("roomid"), rs.getString("roomtype"));
                }
        }
             catch (SQLException e) {
                error = e.getMessage();
            } 
            
            
         catch (ParseException ex) {
            Logger.getLogger(RoomBookingManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally {
                close();
                statementClose();
            }
        return rooms;
    }

}
