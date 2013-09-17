package com.wilmss.android.PrayerRequestJournal.domain;

import java.util.Date;

public class PrayerResponse {
	
	private String disposition;
	private String responseDetail;
	private Date dateEntered;
	private PrayerRequest prayerRequest;
	
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
	
	public void setPrayerRequest(PrayerRequest request){
		prayerRequest=request;
	}
	
	public PrayerRequest getPrayerRequest(){
		return prayerRequest;
	}
	
	public String toString(){
		
		return disposition + ": " + responseDetail;
		
	}
}
