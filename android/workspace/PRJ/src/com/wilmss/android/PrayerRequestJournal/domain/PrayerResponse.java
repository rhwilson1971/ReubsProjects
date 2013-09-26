package com.wilmss.android.PrayerRequestJournal.domain;

import java.util.Date;

public class PrayerResponse {
	
	private long id;
	private String disposition;
	private String responseDetail;
	private Date dateEntered;
	private long prayerRequestId;
	
	public long getId(){
		return id;
	}
	
	public void setId(long id){
		this.id=id;
	}
	
	public String getDisposition(){
		return disposition;
	}
	
	public void setDisposition(String disposition){
		this.disposition = disposition;
	}
	
	public String getResponse(){
		return responseDetail;
	}
	
	public void setResponse(String response){
		responseDetail=response;
	}
	
	public Date getDateEntered(){
		return dateEntered;
	}
	
	public void setDateEntered(Date date){
		dateEntered = date;
	}
	
	public void setPrayerRequestId(long requestId){
		this.prayerRequestId=requestId;
	}
	
	public long getPrayerRequestId(){
		return prayerRequestId;
	}
	
	public String toString(){
		
		return disposition + ": " + responseDetail;
		
	}
}
