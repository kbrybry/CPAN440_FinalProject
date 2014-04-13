/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.manager;

//import java.sql.Date;
import com.personalClasses.Room;
import java.sql.Date;
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
    
    public ArrayList<Room> getRoomDetails(ArrayList floorIDs, ArrayList roomIDs) {
        String type = "";
        String desc = "";
        float price = 0;
        int typeID = 0;
        Room room = new Room();
        ArrayList<Room> rooms = new ArrayList<Room>();
        try {
            open();
            sql = "SELECT * FROM ROOMLISTING WHERE floorid = ? AND roomid = ?";
            stmt = conn.prepareStatement(sql);
            for (int i = 0; i < floorIDs.size(); i++) {
                stmt.setInt(1, Integer.parseInt(floorIDs.get(i).toString()));
                stmt.setInt(2, Integer.parseInt(roomIDs.get(i).toString()));
                rs = stmt.executeQuery();
                if (rs.next()) {
                    typeID = rs.getInt("typeid");
                    sql = "SELECT * FROM ROOMS WHERE typeid = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, typeID);
                    rs = stmt.executeQuery();
                    if(rs.next()) {
                        type = rs.getString("roomtype");
                        desc = rs.getString("description");
                        price = rs.getFloat("price");
                        rooms.add(new Room(type, desc, price));
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomBookingManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally {
            close();
            statementClose();
        }
        
        return rooms;
        
    }
    
    public java.sql.Date convertDate(String date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date uDate = new java.util.Date();
        try {
            uDate = sdf.parse(date);
        } catch (ParseException ex) {
            Logger.getLogger(RoomBookingManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        /*String inDate = sdf.format(checkIn);
        String outDate = sdf.format(checkOut);
        java.util.Date moarCheckIn = sdf.parse(inDate);
        java.util.Date moarCheckOut = sdf.parse(outDate);*/
        java.sql.Date sDate = new java.sql.Date(uDate.getTime());
        return sDate;
    }

    public ArrayList getAvailableRoomIDs(String checkInDate, String checkOutDate) {
        ArrayList roomIDs = new ArrayList();
        try {
            java.sql.Date ci = convertDate(checkInDate);
            java.sql.Date co = convertDate(checkOutDate);
                open();
                sql = "SELECT * from BOOKINGS WHERE checkindate NOT BETWEEN ? AND ? AND checkoutdate NOT BETWEEN ? AND ?";
                stmt = conn.prepareStatement(sql);
                stmt.setDate(1, ci);
                stmt.setDate(2, co);
                stmt.setDate(3, ci);
                stmt.setDate(4, co);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    roomIDs.add(rs.getInt("roomid"));                    
                }
        }
        
             catch (SQLException e) {
                error = e.getMessage();
            } 
        finally {
                close();
                statementClose();
            }
        return roomIDs;
    }
    
    public ArrayList getAvailableFloorIDs(String checkInDate, String checkOutDate) {
        ArrayList floorIDs = new ArrayList();
        try {
            java.sql.Date ci = convertDate(checkInDate);
            java.sql.Date co = convertDate(checkOutDate);
                open();
                sql = "SELECT * from BOOKINGS WHERE checkindate NOT BETWEEN ? AND ? AND checkoutdate NOT BETWEEN ? AND ?";
                stmt = conn.prepareStatement(sql);
                stmt.setDate(1, ci);
                stmt.setDate(2, co);
                stmt.setDate(3, ci);
                stmt.setDate(4, co);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    floorIDs.add(rs.getInt("floorid"));                    
                }
        }
        
             catch (SQLException e) {
                error = e.getMessage();
            } 
        finally {
                close();
                statementClose();
            }
        return floorIDs;
    }

}
