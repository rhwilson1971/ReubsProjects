package com.wilmss.prayerrequestjournal.repository;

public class PrayerRequestor {
	
	int requestorId;
	String firstName;
	String lastName;
	String email;
	
	public int getRequestorId() { return requestorId; }
	public void setRequestorId(int requestorId) {
		this.requestorId= requestorId;
	}
	
	public String getFirstName(){
		return firstName;
	}
	public void setFirstName(String firstName){
		this.firstName=firstName;
	}
	
	public String getLastName(){
		return lastName;
	}
	
	public String getEmail(){
		return email;
	}
	
	public String toString(){
		
		return lastName + ", " + firstName;
	}
}
