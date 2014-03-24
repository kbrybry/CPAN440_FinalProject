/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.personalClasses;
import database.manager.DataManager;
/**
 *
 * @author seang_000
 */
public class Person {

    private String email;
    private String firstName;
    private String lastName;
    private DataManager db = new DataManager();
    
    public Person () {};
    
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
    
}
