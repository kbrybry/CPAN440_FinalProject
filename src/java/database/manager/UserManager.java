    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package database.manager;

import java.sql.SQLException;

/**
 *
 * @author seang_000
 */
public class UserManager extends DataManager {
    
        String email,firstName,lastName,admin;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }
    
    
    public UserManager(){
        super();
    }
    
    //this method creates a new user based on email
     public boolean createNewUser(String userid,String firstname,String lastname,String password){
        boolean created = false;
        try {
         if(verifyUserDoesNotExist(userid)){
            open(); 
            sql = "INSERT INTO USERS(userid, firstname, lastname,userpassword) VALUES(?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userid);
            stmt.setString(2, firstname);
            stmt.setString(3, lastname);
            stmt.setString(4, password);
            stmt.executeUpdate();
         created = true;
         }
        }catch(SQLException e){
       
           error = e.getMessage();
           
        }
        finally{
            close();statementClose();
        }
        return created;
    }
    
     //this method checks to see if the email is already registered to the database
    public boolean verifyUserDoesNotExist(String userid){
        boolean created = false;
        try {
         open(); 
         sql = "SELECT userid FROM USERS where userid=?";
         stmt = conn.prepareStatement(sql);
         stmt.setString(1, userid);
         rs = stmt.executeQuery();
         if (rs.next()){
             error = "E-mail address already registered!";
         }
         else{
             created = true;
         }
         }catch(SQLException e){
           error = e.toString();
           error = e.getMessage();
       
        }
        finally{
            close();statementClose();
        }
        return created;
    }
    
    //this method authenticates login attempts
    public boolean authenticateUser(String userid,String password){
        boolean authenticate = false;
        try {
            open(); 
            sql = "SELECT userid,firstname,lastname,admin FROM USERS where userid=? AND userpassword=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userid);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            
            while(rs.next()){
                authenticate = true;
                email = rs.getString("USERID");
                firstName = rs.getString("FIRSTNAME");
                lastName = rs.getString("LASTNAME");
                admin = rs.getString("ADMIN");
            }
            
         
        }catch(SQLException e){
           error = e.toString();
           error = e.getMessage();
        }
        finally{
            close();statementClose();
        }
        return authenticate;
    }
    
   
}
