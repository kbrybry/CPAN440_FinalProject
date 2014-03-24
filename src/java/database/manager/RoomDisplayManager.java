/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package database.manager;
import com.personalClasses.Room;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author seang_000
 */
public class RoomDisplayManager extends DataManager {
    
   
    
    public ArrayList<Room> getAllTheRooms(){
       ArrayList<Room> rooms = new ArrayList();
        try {
            open(); 
         
             sql = "SELECT * FROM ROOMS";
            stmt = conn.prepareStatement(sql);
         
            rs = stmt.executeQuery();
            while(rs.next()){
             Room room = new Room();
             room.setType(rs.getString("ROOMTYPE"));
             room.setPrice(rs.getFloat("PRICE"));
             room.setDescription(rs.getString("DESCRIPTION"));
             rooms.add(room);
            }
        }catch(SQLException e){
           error = e.toString();
           error = e.getMessage();
        }
        finally{
            close();statementClose();
        }
        return rooms;
    }
}
