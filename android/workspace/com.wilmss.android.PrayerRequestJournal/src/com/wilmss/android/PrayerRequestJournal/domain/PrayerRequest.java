package com.wilmss.android.PrayerRequestJournal.domain;
import java.util.Date;

public class PrayerRequest {

	private long id;
	private String title;
	private String detail;
	private Date dateRequested;
	private PrayerRequestor prayerRequestor;
	
	public long getId(){
		return id;
	}
	
	public void setId(long id){
		this.id = id;
	}
	
	public String getTitle(){
		return title;
	}
	
	public void setTitle(String title){
		this.title = title;
	}
	
	public String getDetail(){
		return detail;
	}
	
	public void setDetail(String detail){
		this.detail = detail;
	}
	
	public PrayerRequestor getRequestor(){
		return this.prayerRequestor;
	}
	
	public void setRequestor(PrayerRequestor requestor){
		this.prayerRequestor=requestor;
	}
	
	public Date getDateRequested(){
		return this.dateRequested;
	}
	
	public void setDateRequested(Date dateRequested){
		this.dateRequested=dateRequested;
	}
	
	public String toString(){
		return this.title;
	}
}
