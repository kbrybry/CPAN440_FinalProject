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
public class Booking {
    
    //fields of class derived from database table information pertaining to bookings
    private int bookingno,floorid,roomid,guests;
    private String dateIn,dateOut,requests,userID,type;
    
    //constructor methods
    public Booking(){}

    //accessor methods
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    
    public int getBookingno() {
        return bookingno;
    }

    public void setBookingno(int bookingno) {
        this.bookingno = bookingno;
    }

    public int getFloorid() {
        return floorid;
    }

    public void setFloorid(int floorid) {
        this.floorid = floorid;
    }

    public int getRoomid() {
        return roomid;
    }

    public void setRoomid(int roomid) {
        this.roomid = roomid;
    }

    public int getGuests() {
        return guests;
    }

    public void setGuests(int guests) {
        this.guests = guests;
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

    public String getRequests() {
        return requests;
    }

    public void setRequests(String requests) {
        this.requests = requests;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
    
    
}
