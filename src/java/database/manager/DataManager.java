/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package database.manager;

import java.sql.*;


public class DataManager {
    
    // connection to database
    final String url = "jdbc:oracle:thin:@dilbert.humber.ca:1521:grok";
    final String user = "grvs0071";
    final String pass = "oracle";
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
    
    
    //connects to oracle database
    public void open(){
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
            conn = DriverManager.getConnection(url, user, pass);
        }
        catch(ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException e){
            error = e.toString();
        }
    }
   
    //closes connection to database
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
