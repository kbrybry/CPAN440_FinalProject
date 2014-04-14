/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.manager;

//import java.sql.Date;
import com.personalClasses.Room;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author deadeye
 */
public class RoomBookingManager extends DataManager {

    DecimalFormat df = new DecimalFormat("#.00");

    float price;
    String roomType;
    String roomDesc;
    int availability;
    String dateIn, dateOut, requests, guests;

    public String getGuests() {
        return guests;
    }

    public void setGuests(String guests) {
        this.guests = guests;
    }

   

    public String getRequests() {
        return requests;
    }

    public void setRequests(String requests) {
        this.requests = requests;
    }

    public String getDateIn() {
        return dateIn;
    }

    public void setDateIn(String dateIn) {
        this.dateIn = dateIn;
    }

    public String getDateOut() {
        return dateOut;
    }

    public void setDateOut(String dateOut) {
        this.dateOut = dateOut;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
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
        openPool();
    }

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

    public Room getAllRoomInformation(String type) {
        Room r = new Room();
        try {
            open();

            sql = "select * from rooms where roomtype=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, type);
            rs = stmt.executeQuery();
            while (rs.next()) {
                r = new Room();
                r.setType(rs.getString("roomType"));
                r.setPrice(rs.getFloat("price"));
                r.setDescription(rs.getString("description"));
            }

        } catch (SQLException e) {

        } finally {
            close();
            statementClose();
        }
        return r;
    }

    public int getMaxBookingNumber() {
        int max = 0;
        try {
            open();
            sql = "select max(bookingno) \"max\" from bookings";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                max = rs.getInt("max");
            }

        } catch (SQLException e) {

        } finally {
            close();
            statementClose();
        }
        return max;
    }

    public void makeBooking(String type, String dateIn, String dateOut, int guests, String requests, String userID) {
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
                            stmt = conn.prepareStatement("SELECT * FROM BOOKINGS JOIN roomlisting USING (floorid,roomid) WHERE (checkindate BETWEEN ? AND ? OR checkoutdate BETWEEN ? AND ?) AND roomid=? AND floorid=?");
                            stmt.setString(1, dateIn);
                            stmt.setString(2, dateOut);
                            stmt.setString(3, dateIn);
                            stmt.setString(4, dateOut);
                            stmt.setString(5, room);
                            stmt.setString(6, floor);
                            rs = stmt.executeQuery();
                            if (!rs.next()) {
                                sql = "INSERT INTO BOOKINGS(checkindate,checkoutdate,floorid,roomid,requests,guests,userid) VALUES(?,?,?,?,?,?,?)";
                                stmt = conn.prepareStatement(sql);
                                stmt.setString(1, dateIn);
                                stmt.setString(2, dateOut);
                                stmt.setString(3, floor);
                                stmt.setString(4, room);
                                stmt.setString(5, requests);
                                stmt.setInt(6, guests);
                                stmt.setString(7, userID);
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

    public String getAvailableRooms(String dateIn, String dateOut) {
        ArrayList<String> floors = new ArrayList();
        ArrayList<String> roomsAvailable = new ArrayList();
        boolean booked = false;
        try {
            open();
            for (String type : getAllRoomTypes()) {
                booked = false;
                open();
                sql = "SELECT DISTINCT floorid FROM roomlisting JOIN ROOMS USING (typeid) where roomtype=?";
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
                                stmt = conn.prepareStatement("SELECT * FROM BOOKINGS JOIN roomlisting USING (floorid,roomid) WHERE (checkindate BETWEEN ? AND ? OR checkoutdate BETWEEN ? AND ?) AND roomid=? AND floorid=?");
                                stmt.setString(1, dateIn);
                                stmt.setString(2, dateOut);
                                stmt.setString(3, dateIn);
                                stmt.setString(4, dateOut);
                                stmt.setString(5, room);
                                stmt.setString(6, floor);
                                rs = stmt.executeQuery();
                                if (!rs.next()) {
                                    roomsAvailable.add(type);
                                    booked = true;
                                    break;
                                }
                            }
                        }
                    }
                }
            }//getallroomtypes

        } catch (SQLException e) {

        } finally {
            close();
            statementClose();
        }
        String results = "";
        results += "<table style=\"width:1000px\">";
        results += "<tr> <th>Room Type</th> <th>Price</th> <th>Description</th>";
        for (String item : roomsAvailable) {
            Room r = getAllRoomInformation(item);
            results += "<tr>";
            results += "<td>" + r.getType() + "<br><form method=\"POST\" action=\"bookings.jsp\"><button class=\"btn btn-info btn-xs\" name=\"" + r.getType() + "\">Book Now!</button></form>" + "</td>";
            results += "<td>$" + df.format(r.getPrice()) + " per night</td>";
            results += "<td>" + r.getDescription() + "</td>";
            results += "</tr>";
        }
        results += "</table>";
        return results;
    }

}
