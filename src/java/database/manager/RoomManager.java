/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database.manager;

import com.personalClasses.Room;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

/**
 *
 * @author seang_000
 */
public class RoomManager extends DataManager {

    //fields of the class
    private Room room;
    DecimalFormat df = new DecimalFormat("#.00");
    String form;

    //constructor
    public RoomManager() {
        super();
        room = new Room();
    }
/////////////////////////////////////QUERY METHODS///////////////////////////////////////

    //method that enters new room information into the database
    public void addNewRoom(String roomtype, float price, String desc){
        try {
            open();

            sql = "INSERT INTO ROOMS(ROOMTYPE,PRICE,DESCRIPTION) VALUES(?,?,?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomtype);
            stmt.setFloat(2, price);
            stmt.setString(3, desc);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
    }
    
    //method that removes room data from the database
    public void deleteRoom(int id){
        try {
            open();
            sql = "DELETE FROM ROOMS WHERE TYPEID=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.execute();
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
    }
    
    //method that edits current database entry
    public void editRoom(String roomtype,float price, String desc,int id){
        try {
            open();
            sql = "UPDATE ROOMS SET ROOMTYPE=?, PRICE=?,DESCRIPTION=? WHERE TYPEID=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomtype);
            stmt.setFloat(2, price);
            stmt.setString(3, desc);
            stmt.setInt(4, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
    }
    
    //this method searches the database for a specific room type based on user given parameter and returns room object
    /**
 * Room type is not unique. Bad parameter to use to retrieve data.
 *
     * @param roomtype
     * @return 
 * @deprecated use {getSpecificRoomByID} instead.  
 */
@Deprecated
    public Room getSpecificRoomByType(String roomtype) {
        try {
            open();

            sql = "SELECT * FROM ROOMS WHERE UPPER(ROOMTYPE) =?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomtype);
            rs = stmt.executeQuery();
            while (rs.next()) {
                room = new Room();
                room.setType(rs.getString("ROOMTYPE"));
                room.setPrice(rs.getFloat("PRICE"));
                room.setDescription(rs.getString("DESCRIPTION"));
            }
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
        return room;
    }

    //this method searches the database for a specific room id based on user given parameter and returns room object
    public Room getSpecificRoomByID(int roomid) {
        try {
            open();

            sql = "SELECT * FROM ROOMS WHERE typeid=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, roomid);
            rs = stmt.executeQuery();
            while (rs.next()) {
                room = new Room();
                room.setType(rs.getString("ROOMTYPE"));
                room.setPrice(rs.getFloat("PRICE"));
                room.setDescription(rs.getString("DESCRIPTION"));
            }
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }

        return room;
    }

    //this method returns all of the data from the rooms data and stores it into an arraylist of room objects
    public ArrayList<Room> getAllTheRooms() {
        ArrayList<Room> rooms = new ArrayList();
        try {
            open();

            sql = "SELECT * FROM ROOMS";
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();
            while (rs.next()) {
                room = new Room();
                room.setType(rs.getString("ROOMTYPE"));
                room.setPrice(rs.getFloat("PRICE"));
                room.setDescription(rs.getString("DESCRIPTION"));
                room.setId(rs.getInt("TYPEID"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            error = e.toString();
        } finally {
            close();
            statementClose();
        }
        return rooms;
    }

    /////////////////////////FORM CREATION BEAN METHODS/////////////////////////////////////////////
    
    //this method allows Java Bean to create edit room form allowing admin to edit room properties in the database
    public String makeEditRoomForm(String type, float price, String desc) {
        form = "";
        //starts form
        form = "<form class=\"form-horizontal editForm\" role=\"form\" method=\"POST\" action=\"admin.jsp\">";
        //creates room type label and input box 
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Room Type:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\" type=\"text\" name=\"editRoomType\" value=\"" + type + "\" required/>";
        form += "</div>";
        form += "</div>";
        //creates room price label and input box
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Room Price:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\"  type=\"text\" name=\"editRoomPrice\" value=\"" + df.format(price) + "\" required/>";
        form += "</div>";
        form += "</div>";
        //creates room description label and text area
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Room Description:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<textarea class=\"form-control\" name=\"editRoomDescription\" rows=\"10\" cols=\"100\" required>" + desc + "</textarea>";
        form += "</div>";
        form += "</div>";
        //buttons for form
        form += "<div class=\"form-group myButtonSeparator\">";
        form += "<div class=\"col-sm-offset-2 col-sm-10\">";
        form += "<button type=\"submit\" class=\"btn btn-warning\" name=\"editEdit\">Edit</button> <button type=\"submit\" class=\"btn btn-primary\" name=\"editCancel\">Cancel</button> <br><br>";
        form += "DANGER! <button type=\"submit\" class=\"btn btn-danger\" name=\"editDelete\">Delete</button> !DANGER";
        form += "</div>";
        form += "</div>";

        //ends form
        form += "</form>";
        return form;
    }

    //this method makes the edit search form that allows admin to search for rooms in the database
    public String makeEditSearchForm() {
        form = "";
        form ="<form class=\"form-horizontal myForm\" role=\"form\" method=\"POST\" action=\"admin.jsp\">";
        form+="<div class=\"form-group\">";
	form+="<label class=\"col-sm-2 control-label\">ID:</label>";			
	form+="<div class=\"col-sm-8\">";			
	form+="<input class=\"form-control\" type=\"text\" name=\"roomid\" placeholder=\"Enter ID\"/>";		
        form+="</div>";                        
        form+="<button type=\"submit\" class=\"btn btn-default\" name=\"idSearch\">Search</button>";	
	form+="</div>"; 	
        form+="</form>";
        return form;
    }
    
    //this method creates the form that allows admin to add new rooms to the database
    public String makeAddRoomForm(){
        form = "";
        //starts form
        form = "<form class=\"form-horizontal\" role=\"form\" method=\"POST\" action=\"admin.jsp\">";
        //creates room type label and input box 
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Room Type:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\" type=\"text\" name=\"addRoomType\" required/>";
        form += "</div>";
        form += "</div>";
        //creates room price label and input box
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Room Price:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<input class=\"form-control\"  type=\"text\" name=\"addRoomPrice\" required/>";
        form += "</div>";
        form += "</div>";
        //creates room description label and text area
        form += "<div class=\"form-group\">";
        form += "<label class=\"col-sm-2 control-label\">Room Description:</label>";
        form += "<div class=\"col-sm-8\">";
        form += "<textarea class=\"form-control\" name=\"addRoomDescription\" rows=\"10\" cols=\"100\" required></textarea>";
        form += "</div>";
        form += "</div>";
        //button for form
        form += "<div class=\"form-group myButtonSeparator\">";
        form += "<div class=\"col-sm-offset-2 col-sm-10\">";
        form += "<button type=\"submit\" class=\"btn btn-success\" name=\"addRoom\">Add Room</button> <br><br>";
        form += "</div>";
        form += "</div>";
        //ends form
        form += "</form>";
        return form;
    }
}
