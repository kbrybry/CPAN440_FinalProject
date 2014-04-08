/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package database.manager;

import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class DataManager {
    
    // connection to database
    Context ctx; 
    DataSource ds;
    protected String error = "Nothing is wrong";
    
    Connection conn = null;
    PreparedStatement stmt;
    String sql;
    ResultSet rs;
    
    public DataManager(){}

    //accessor methods
    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
    
    //opens connection pool for use
    public void openPool() throws NamingException{
        this.ctx = new InitialContext();
        ds = (DataSource)ctx.lookup("jdbc/hotelDataSource"); 
    }
    //connects to pool
    public void open(){
        try{
           conn = ds.getConnection("grvs0071","oracle");
        }
        catch(SQLException e){
            error = e.toString();
        }
    }
   
    //closes connection to pool
    public void close(){
   
        try{
            if(conn != null){
                conn.close();
            }
        }
        catch(SQLException e){
            error = e.toString();
        }
    }
    
    //closes statement
    public void statementClose(){
        try{
            if(stmt != null){
                stmt.close();
            }
        }
        catch(SQLException e){
            error = e.toString();
        }
    }
    
   
    
}
