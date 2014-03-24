/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.personalClasses;

/**
 *
 * @author seang_000
 */
public class Room {
    String type,description;
    float price;

    public Room(String type, String description, float price) {
        this.type = type;
        this.description = description;
        this.price = price;
    }

    public Room(){};
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
    
    
}
