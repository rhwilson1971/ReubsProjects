package com.wilmss.android.PrayerRequestJournal.domain;

public class PrayerRequestor {
	
	long id;
	String firstName;
	String lastName;
	String email;
	
	public long getId() { return id; }
	public void setRequestorId(long id) {
		this.id= id;
	}
	
	public String getFirstName(){
		return firstName;
	}
	public void setFirstName(String firstName){
		this.firstName=firstName;
	}
	
	public void setLastNamse(String lastName){
		this.lastName = lastName;
	}
	
	public String getLastName(){
		return lastName;
	}
	
	public void setEmai(String email){
		this.email = email;
	}
	public String getEmail(){
		return email;
	}
	
	public String toString(){
		
		return lastName + ", " + firstName;
	}
}
